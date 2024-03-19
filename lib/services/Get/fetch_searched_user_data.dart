import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/errorDialogController.dart';
import '../../controllers/searchedUserController.dart';
import 'package:http/http.dart' as http;

import '../../models/userFollowerModel.dart';

Future<bool> fetchSearchedUserData(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var controller = Get.put(SearchedUserController());
  bool cookieStatus = prefs.getBool('cookie_status') ?? false;

  if (cookieStatus == true) {
    String? instagramId = prefs.getString('ds_user_id');
    String? sessionId = prefs.getString('sessionid');
    String url;
    url =
        'https://instagram.com/api/v1/users/web_profile_info/?username=$username';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
        'X-IG-App-ID': '936619743392459',
        'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
      });
      if (response.statusCode == 200) {
        controller.userData.value = null;
        var jsonMap = jsonDecode(response.body);

        var jsonList = jsonMap['data']['user'];
        controller.userData.value =
            UserFollowerDataModel.fromJson(jsonEncode(jsonList));

        return true;
      } else {
        log("TAKIPCININ VERILERINI ALIRKEN BIR HATA OLUSTU");
        return false;
      }
    } catch (e) {
      log("TAKIPCININ VERILERINI ALIRKEN BIR HATA OLUSTU $e");
      return false;
    }
  } else {
    return false;
  }
}
