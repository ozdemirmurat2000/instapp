import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../controllers/errorDialogController.dart';

Future<bool> fetchUserFollowersData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool cookieStatus = prefs.getBool('cookie_status') ?? false;
  String checkData = prefs.getString("first_followers_data") ?? '';

  if (cookieStatus == true) {
    String? instagramId = prefs.getString('ds_user_id');
    String? csrftoken = prefs.getString('csrftoken');
    String? sessionId = prefs.getString('sessionid');
    String url;
    url = 'https://i.instagram.com/api/v1/friendships/$instagramId/followers/';
    try {
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
        List users = data['users'];

        // ILK KEZ TAKIPCI BILGILERI ALINACAKSA

        if (checkData.isEmpty) {
          await prefs.setString('first_followers_data', jsonEncode(users));
          log("ILK VERILER ALINDI");
        }
        // EGER DAHA ONCE ALINDIYSA YENI BILGILERI AL

        else {
          await prefs.setString('new_followers_data', jsonEncode(users));
          log("YENI VERILER ALINDI");
        }

        log('FETCH USER FOLLOWERS TAMAMLANDI');

        return true;
      } else {
        log("fetch user followers data hata olustu.");
        return false;
      }
    } catch (e) {
      log("fetch user followers data hata olustu. $e");
      ErrorDialogs.gosterHataDialogi();

      return false;
    }
  } else {
    ErrorDialogs.gosterHataDialogi();

    return false;
  }
}
