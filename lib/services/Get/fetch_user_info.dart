import 'dart:convert';
import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../controllers/errorDialogController.dart';

Future<bool> fetchUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool cookieStatus = prefs.getBool('cookie_status') ?? false;
  bool userDataStaus = prefs.getBool('user_data_status') ?? false;

  if (cookieStatus == true && userDataStaus == false) {
    try {
      String instagramId = prefs.getString('ds_user_id')!;
      String csrftoken = prefs.getString('csrftoken')!;
      String sessionId = prefs.getString('sessionid')!;
      String url = 'https://i.instagram.com/api/v1/users/$instagramId/info/';

      final response = await http.get(Uri.parse(url), headers: {
        'sec-ch-ua':
            '"Chromium";v="94", "Google Chrome";v="94", ";Not A Brand";v="99"',
        'X-IG-WWW-Claim':
            'hmac.AR2WwJKC3WR-MoU7JMDfFFID-7fdmd1WlxNLEkz2dna04cuf',
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
          log("FETC USER INFO HATA OLUSTU");
          return false;
        } else {
          OneSignal.login(
              prefs.getString('device_id') ?? 'onesignal id atanamadi');
          await prefs.setString('username', data["user"]["username"]);
          await prefs.setString(
              'profile_pic_url', data["user"]["profile_pic_url"]);
          await prefs.setString('full_name', data["user"]["full_name"]);
          await prefs.setString('biography', data["user"]["biography"]);
          await prefs.setString(
              'follower_count', data["user"]["follower_count"].toString());
          await prefs.setString(
              'following_count', data["user"]["following_count"].toString());
          await prefs.setString(
              'media_count', data["user"]["media_count"].toString());
          await prefs.setString('onesignal_id',
              OneSignal.User.pushSubscription.id ?? 'onesignal id yazilamadi');
          await prefs.setBool('user_data_status', true);

          log('FETCH USER INFO VERILERI TAMAMLADIN');

          return true;
        }
      } else {
        ErrorDialogs.gosterHataDialogi();

        log("FETC USER INFO HATA OLUSTU");
        return false;
      }
    } catch (e) {
      ErrorDialogs.gosterHataDialogi();

      log("FETC USER INFO HATA OLUSTU $e");
      return false;
    }
  } else {
    ErrorDialogs.gosterHataDialogi();

    log("FETC USER INFO HATA OLUSTU");
    return false;
  }
}
