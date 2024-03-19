import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../controllers/errorDialogController.dart';

Future<bool> fetchCookies() async {
  final cookieManager = WebviewCookieManager();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool cookieStatus = preferences.getBool('cookie_status') ?? false;
  try {
    if (cookieStatus == false) {
      await Future.delayed(const Duration(seconds: 3));

      // KULLANICI INSTAGRAM CEREZLERI ALMA
      final gotCookies =
          await cookieManager.getCookies('https://www.instagram.com/');

      // ALINAN CEREZLERI MAP YAPISINA DONUSTURMA

      Map map = {for (var item in gotCookies) item.name: item.value};

      if (map.containsKey('ds_user_id') &&
          map.containsKey('ig_did') &&
          map.containsKey('ig_nrcb') &&
          map.containsKey('csrftoken') &&
          map.containsKey('mid') &&
          map.containsKey('sessionid') &&
          map.containsKey('shbid') &&
          map.containsKey('shbts') &&
          map.containsKey('rur')) {
        map.forEach((key, value) async {
          await preferences.setString(key, value);
        });
        log('COOKILER ALINDI');

        await preferences.setBool('cookie_status', true);
        return true;
      } else {
        ErrorDialogs.gosterHataDialogi();

        return false;
      }
    }
  } catch (e) {
    log('COOKIEDE BIR HATA OLUSTU $e');
    ErrorDialogs.gosterHataDialogi();

    return false;
  }
  ErrorDialogs.gosterHataDialogi();

  return false;
}
