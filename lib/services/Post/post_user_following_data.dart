import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> postUserFollowingData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  String userToken = pref.getString('user_token') ?? '';
  String userFollowingData = pref.getString('first_following_data') ?? '';

  if (userToken.isEmpty) {
    log('user token bulunamadu');
    return false;
  } else if (userFollowingData.isEmpty) {
    log('user following data bulunamadi');
    return false;
  } else {
    final res = await http.post(
        Uri.parse('http://profileanalyzerapp.com/mobile/getUserFollowing.php'),
        body: {
          'key': "spyspy", // sabit değişken
          'users_token': userToken, // loginUser.php'den dönen users_token
          'followers': userFollowingData,
        });
    if (res.statusCode == 200) {
      log('POST USER FOLLOWING TAMAMLANDI');

      return true;
    } else {
      log('POST USER FOLLOWING BIR HATA OLUSTU');

      return false;
    }
  }
}
