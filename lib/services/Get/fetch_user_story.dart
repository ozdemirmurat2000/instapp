import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/errorDialogController.dart';
import '../../controllers/usersStoriesController.dart';
import 'package:http/http.dart' as http;

import '../../models/userStoryModel.dart';

Future<bool> fetchUserStory(String userID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var controllerStory = Get.put(UserStoriesController());

  bool cookieStatus = prefs.getBool('cookie_status') ?? false;

  if (cookieStatus == true) {
    String? instagramId = prefs.getString('ds_user_id');
    String? sessionId = prefs.getString('sessionid');
    String url;
    url = 'https://www.instagram.com/api/v1/feed/user/$userID/story';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
        'X-IG-App-ID': '936619743392459',
        'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
      });
      if (response.statusCode == 200) {
        log('HIKAYELER GETIRILDI');
        var json = jsonDecode(response.body);
        var newJson = await json["reel"]['items'];

        // log(jsonEncode(newJson));
        controllerStory.userStories.value = UserStoryDataModel();

        controllerStory.userStories.value =
            UserStoryDataModel.fromJson(jsonEncode(newJson));

        return true;
      } else {
        ErrorDialogs.gosterHataDialogi();

        log("hikayede bir hata var ${response.body}");
        return false;
      }
    } catch (e) {
      ErrorDialogs.gosterHataDialogi();

      log('USER STORYSI GETIRILIRKEN BIR HATA OLUTSU $e');
      return false;
    }
  } else {
    ErrorDialogs.gosterHataDialogi();

    log("USER STORYSI GETIRILIRKEN BIR HATA OLUTSU");
    return false;
  }
}
