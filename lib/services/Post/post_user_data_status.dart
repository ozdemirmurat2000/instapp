import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../controllers/searchedUserController.dart';
import '../../models/userPremiumStatusModel.dart';

Future<bool> postUserDataStatus() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var controller = Get.put(SearchedUserController());

  String userToken = pref.getString('user_token') ?? '';

  if (userToken.isEmpty) {
    log('user token bulunamadu');
    return false;
  } else {
    final res = await http.post(
        Uri.parse('http://profileanalyzerapp.com/mobile/getUserData.php'),
        body: {
          'key': "spyspy", // sabit değişken
          'users_token': userToken, // loginUser.php'den dönen users_token
          'app_name': 'xreports',
        });
    if (res.statusCode == 200) {
      var json = res.body;
      controller.userPremiumStatus.value =
          UserPremiumStatusModel.fromJson(json);

      log('${controller.userPremiumStatus.value.isPremium}');
      log('POST USER  DATA TAMAMLANDI');

      return true;
    } else {
      log("POST USER DATA BIR HATA OLUSTU");
      return false;
    }
  }
}
