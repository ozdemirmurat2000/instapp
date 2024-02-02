import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfo {
  static Future getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? instagramId = prefs.getString('ds_user_id');
    String? csrftoken = prefs.getString('csrftoken');
    String? sessionId = prefs.getString('sessionid');
    String url;
    print(instagramId);
    print(csrftoken);
    print(sessionId);
    url = 'https://i.instagram.com/api/v1/users/$instagramId/info/';
    final response = await http.get(Uri.parse(url), headers: {
      'sec-ch-ua':
          '"Chromium";v="94", "Google Chrome";v="94", ";Not A Brand";v="99"',
      'X-IG-WWW-Claim': 'hmac.AR2WwJKC3WR-MoU7JMDfFFID-7fdmd1WlxNLEkz2dna04cuf',
      'sec-ch-ua-mobile': '?0',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36',
      'Accept': '*/*',
      'X-ASBD-ID': '198387',
      'sec-ch-ua-platform': '"macOS"',
      'X-IG-App-ID': '936619743392459',
      'cookie': 'csrftoken=$csrftoken;sessionid=$sessionId;',
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data.containsKey("status") && data["status"] == "fail") {
        return false;
      } else {
        prefs.setString('username', data["user"]["username"]);
        prefs.setString('profile_pic_url', data["user"]["profile_pic_url"]);
        prefs.setString('full_name', data["user"]["full_name"]);
        prefs.setString('biography', data["user"]["biography"]);
        prefs.setString(
            'follower_count', data["user"]["follower_count"].toString());
        prefs.setString(
            'following_count', data["user"]["following_count"].toString());
        prefs.setString('media_count', data["user"]["media_count"].toString());
        prefs.setBool('login_status', true);

        print('veriler yazildi');
        var controller = Get.put(LoginStatusController());

        controller.loginStatus.value = true;

        controller.update();

        return true;
      }
    } else {
      var controller = Get.put(LoginStatusController());

      controller.loginStatus.value = false;

      return false;
    }
  }
}
