import 'package:instapp/services/getUserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class GetCookies {
  static Future getCookies() async {
    final cookieManager = WebviewCookieManager();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // KULLANICI INSTAGRAM CEREZLERI ALMA
    final gotCookies =
        await cookieManager.getCookies('https://www.instagram.com/');

    // ALINAN CEREZLERI MAP YAPISINA DONUSTURMA

    Map map = {for (var item in gotCookies) item.name: item.value};

    map.forEach((key, value) {
      preferences.setString(key, value);
    });
    print('cerez cihaza yazildi');
  }
}
