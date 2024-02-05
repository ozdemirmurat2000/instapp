import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:instapp/controllers/errorDialogController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class PostServices {
  ///
  ///
  /// POST USER INFO
  ///
  ///
  static Future postUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool cookieStatus = pref.getBool('cookie_status') ?? false;
    bool userInfoStatus = pref.getBool('user_info_status') ?? false;

    if (cookieStatus == true && userInfoStatus == false) {
      try {
        final response = await http.post(
          Uri.parse('http://profileanalyzerapp.com/mobile/loginUser.php'),
          body: {
            "key": "spyspy", //sabit değişken
            "username": pref.getString('username'), //instagram kullanıcı adı
            "instagram_id": pref.getString('ds_user_id'), //cookieden ds_user_id
            "ig_did": pref.getString('ig_did'), //cookieden
            "ig_nrcb": pref.getString('ig_nrcb'), //cookieden
            "csrftoken": pref.getString('csrftoken'), //cookieden
            "mid": pref.getString('mid'), //cookieden
            "ds_user_id": pref.getString('ds_user_id'), //cookieden ds_user_id
            "sessionid": pref.getString('sessionid'), //cookieden
            "shbid": pref.getString('shbid'), //cookieden
            "shbts": pref.getString('shbts'), //cookieden
            "rur": pref.getString('rur'), //cookieden
            "platform": "android", //sabit değişken
            "device_id": pref.getString('device_id'), //cihaz id si
            "onesignal_id": pref.getString('onesignal_id'), //onesignal_id
            "referrer":
                pref.getString('referrer') ?? '', //play install referrer
            "language_code":
                ui.window.locale.languageCode, //kullanıcının uygulama dili
            "app": "xreports" //uygulama kısa adı sabit değişken
          },
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data["result"] != 200) {
            log('${response.statusCode} > ${response.body}');
            ErrorDialogs.gosterHataDialogi();
          } else {
            log('user_token basariyla alindi');
            await pref.setBool('user_info_status', true);
            await pref.setString('user_token', data['users_token']);
            await pref.setInt('user_coin', data['coin']);
            log('POST USER INFO TAMAMLANDI');

            return true;
          }
        } else {
          log('${response.statusCode} > ${response.body}');
          ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log(' Post user infoda bir hata olustu $e');
      }
    }
  }

  ///
  ///
  /// POST USER FOLLOWING DATA
  ///
  ///

  static Future postUserFollowingData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String userToken = pref.getString('user_token') ?? '';
    String userFollowingData = pref.getString('current_following_data') ?? '';

    if (userToken.isEmpty) {
      log('user token bulunamadu');
    } else if (userFollowingData.isEmpty) {
      log('user following data bulunamadi');
    } else {
      final res = await http.post(
          Uri.parse(
              'http://profileanalyzerapp.com/mobile/getUserFollowing.php'),
          body: {
            'key': "spyspy", // sabit değişken
            'users_token': userToken, // loginUser.php'den dönen users_token
            'followers': userFollowingData,
          });
      if (res.statusCode == 200) {
        log('POST USER FOLLOWING TAMAMLANDI');

        return true;
      } else {
        ErrorDialogs.gosterHataDialogi();
        log('hata ${res.statusCode} ${res.body}');
      }
    }
  }

  ///
  ///
  /// POST USER FOLLOWERS DATA
  ///
  ///

  static Future postUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String userToken = pref.getString('user_token') ?? '';
    bool showAppPreview = pref.getBool('show_app_preview') ?? false;

    if (userToken.isEmpty) {
      log('user token bulunamadu');
    } else {
      if (showAppPreview == false) {
        final res = await http.post(
            Uri.parse('http://profileanalyzerapp.com/mobile/getUserData.php'),
            body: {
              'key': "spyspy", // sabit değişken
              'users_token': userToken, // loginUser.php'den dönen users_token
              'app_name': 'xreports',
            });
        if (res.statusCode == 200) {
          log('${jsonDecode(res.body)}');
          log('POST USER TAMAMLANDI');
          pref.setBool('show_app_preview', true);

          return true;
        } else {
          ErrorDialogs.gosterHataDialogi();
          log('hata ${res.statusCode} ${res.body}');
        }
      }
    }
  }
}
