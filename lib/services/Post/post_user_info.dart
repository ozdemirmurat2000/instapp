import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

Future<bool> postUserInfo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool cookieStatus = pref.getBool('cookie_status') ?? false;

  if (cookieStatus == true) {
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
          "device_id": pref.getString('device_id') ?? '', //cihaz id si
          "onesignal_id": pref.getString('onesignal_id') ?? '', //onesignal_id
          "referrer": pref.getString('referrer') ?? '', //play install referrer
          "language_code":
              ui.window.locale.languageCode, //kullanıcının uygulama dili
          "app": "xreports" //uygulama kısa adı sabit değişken
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log('user_token basariyla alindi');
        await pref.setString('user_token', data['users_token']);
        await pref.setInt('user_coin', data['coin']);
        log('POST USER INFO TAMAMLANDI');
        return true;
      } else {
        log('POST USER INFO DA HATA OLUSTU');

        return false;
      }
    } catch (e) {
      log(' Post user infoda bir hata olustu $e');
      return false;
    }
  } else {
    log(' Post user infoda bir hata olustu ');

    return false;
  }
}
