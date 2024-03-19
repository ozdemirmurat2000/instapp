import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/errorDialogController.dart';
import '../../controllers/usersStoriesController.dart';
import 'package:http/http.dart' as http;

import '../../models/storyModel.dart';

Future<bool> fetchUserStories() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var controller = Get.put(UserStoriesController());

  bool cookieStatus = prefs.getBool('cookie_status') ?? false;

  if (cookieStatus == true) {
    String? instagramId = prefs.getString('ds_user_id');
    String? sessionId = prefs.getString('sessionid');
    String url;
    url = 'https://www.instagram.com/api/v1/feed/reels_tray/';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
        'X-IG-App-ID': '936619743392459',
        'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
      });
      if (response.statusCode == 200) {
        var jsonDataList = json.decode(response.body);
        var jsonDecodeList = jsonDataList['tray'];

        // log('$jsonDecodeList');

        List<InstagramReel> instagramReels = [];
        for (var jsonData in jsonDecodeList) {
          instagramReels.add(InstagramReel.fromJson(jsonData));
        }
        controller.instagramReels.value = instagramReels;
        log('HIKAYELER BASARIYLA ALINDI');

        return true;
      } else {
        ErrorDialogs.gosterHataDialogi();

        log("FETCH USER STORIES TE HATA OLUSTU");
        return false;
      }
    } catch (e) {
      ErrorDialogs.gosterHataDialogi();

      log("FETCH USER STORIES TE HATA OLUSTU $e");
      return false;
    }
  } else {
    ErrorDialogs.gosterHataDialogi();

    log("FETCH USER STORIES TE HATA OLUSTU");
    return false;
  }
}
