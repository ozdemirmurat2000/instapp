import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/errorDialogController.dart';
import '../../controllers/searchedUserController.dart';
import 'package:http/http.dart' as http;

import '../../models/searchedUserModel.dart';

Future<bool> fetchSearchUser(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var controller = Get.put(SearchedUserController());
  bool cookieStatus = prefs.getBool('cookie_status') ?? false;

  if (cookieStatus == true) {
    String? instagramId = prefs.getString('ds_user_id');
    String? sessionId = prefs.getString('sessionid');
    String url;
    url =
        'https://www.instagram.com/api/v1/web/search/topsearch/?context=blended&query=$value&rank_token=0.6872023492760977&include_reel=true';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
        'X-IG-App-ID': '936619743392459',
        'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var jsonDecodeList = data['users'];

        // log('$jsonDecodeList');

        List<SearchedUser> searchedUser = [];

        controller.users.clear();
        for (var jsonData in jsonDecodeList) {
          searchedUser.add(SearchedUser.fromJson(jsonData));
        }

        controller.users.value = searchedUser;

        return true;
      } else {
        ErrorDialogs.gosterHataDialogi();

        log("KULLANICI ARANIRKEN HATA OLUSTU");
        return false;
      }
    } catch (e) {
      ErrorDialogs.gosterHataDialogi();

      log("KULLANICI ARANIRKEN HATA OLUSTU $e");
      return false;
    }
  } else {
    ErrorDialogs.gosterHataDialogi();

    return false;
  }
}
