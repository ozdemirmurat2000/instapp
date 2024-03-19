import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/errorDialogController.dart';
import '../../controllers/searchedUserController.dart';

Future<bool> fetchPostData(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool cookieStatus = prefs.getBool('cookie_status') ?? false;
  var controller = Get.put(SearchedUserController());

  String urlPost =
      'https://www.instagram.com/api/v1/feed/user/$username/username/?count=15';

  if (cookieStatus) {
    String? instagramId = prefs.getString('ds_user_id');
    String? sessionId = prefs.getString('sessionid');

    try {
      final response = await http.get(Uri.parse(urlPost), headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
        'X-IG-App-ID': '936619743392459',
        'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
      });

      if (response.statusCode == 200) {
        var jsonMap2 = jsonDecode(response.body);
        List data = jsonMap2['items'];
        controller.userPosts.clear();

        for (var element in data) {
          controller.userPosts
              .add(element['image_versions2']['candidates'][0]['url']);
        }

        return true;
      }
    } catch (e) {
      log(' KULLANICI POST POST ALINIRKEN BIR HATA OLUSTU $e');
      fetchPostData(username);
      ErrorDialogs.gosterHataDialogi();

      return false;
    }
  }
  ErrorDialogs.gosterHataDialogi();

  return true;
}
