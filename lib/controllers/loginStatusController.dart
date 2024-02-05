import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:instapp/models/userDataModel.dart';
import 'package:instapp/models/userFollowersModel.dart';
import 'package:instapp/models/userFollowingModel.dart';
import 'package:instapp/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginStatusController extends GetxController {
  RxBool loginStatus = false.obs;
  static bool webView = false;

  var controller = WebViewController().obs;

  var userDataModel = UserDataModel().obs;
  RxList<UserFollowersModel> userFollowersList = <UserFollowersModel>[].obs;
  RxList<UserFollowingModel> userFollowingList = <UserFollowingModel>[].obs;

  RxInt newFollowersCount = 0.obs;
  RxInt lostFollowersCount = 0.obs;

  RxList unFollowing = [].obs;
  RxList unFollowers = [].obs;

  Future checkStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    userDataModel.value.media_count = pref.getString('media_count') ?? '';
    userDataModel.value.userName = pref.getString('username') ?? '';
    userDataModel.value.userNameSurname = pref.getString('full_name') ?? '';
    userDataModel.value.userFollowers = pref.getString('follower_count') ?? '';
    userDataModel.value.userFollowed = pref.getString('following_count') ?? '';
    userDataModel.value.userImageURL = pref.getString('profile_pic_url') ?? '';
    String dataFolowing = pref.getString('current_following_data') ?? '';
    String dataFolowers = pref.getString('current_followers_data') ?? '';
    final followingList = jsonDecode(dataFolowing) as List<dynamic>;
    final followersList = jsonDecode(dataFolowers) as List<dynamic>;

    final userFollowingModel =
        followingList.map((item) => UserFollowingModel.fromJson(item)).toList();
    final userFollowersModel =
        followersList.map((item) => UserFollowersModel.fromJson(item)).toList();

    userFollowersList.value = userFollowersModel;
    userFollowingList.value = userFollowingModel;

    if (int.parse(userDataModel.value.userFollowers) >
        userFollowersModel.length) {
      newFollowersCount.value = int.parse(userDataModel.value.userFollowers) -
          userFollowersModel.length;
    } else {
      lostFollowersCount.value = userFollowersModel.length -
          int.parse(userDataModel.value.userFollowers);
    }

    List<String?> kullaniciAdlari1 =
        userFollowersList.map((user) => user.username).toList();
    Set<String?> kullaniciAdlari2 =
        userFollowingModel.map((user) => user.username).toSet();

    log('${kullaniciAdlari1.length}');
  }

  Future<bool> logOutAndDeleteAccount(bool isExit) async {
    if (isExit) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String saveDeviceID = prefs.getString('device_id') ?? '';
      String saveFollowing = prefs.getString('current_followers_data') ?? '';
      String saveFollowers = prefs.getString('current_following_data') ?? '';
      String saveFollowingDataTime =
          prefs.getString('following_data_time') ?? '';
      String saveFollowersDataTime =
          prefs.getString('followers_data_time') ?? '';
      bool saveFollowingStatus =
          prefs.getBool('following_data_status') ?? false;
      bool saveFollowersStatus =
          prefs.getBool('followers_data_status') ?? false;
      await prefs.clear();
      await prefs.setString('device_id', saveDeviceID);

      await prefs.setString('current_following_data', saveFollowing);
      await prefs.setString('current_followers_data', saveFollowers);
      await prefs.setBool('following_data_status', saveFollowingStatus);
      await prefs.setBool('followers_data_status', saveFollowersStatus);
      await prefs.setString('following_data_time', saveFollowingDataTime);
      await prefs.setString('followers_data_time', saveFollowersDataTime);
      final cookieManager = WebviewCookieManager();
      await cookieManager.clearCookies();
      await prefs.setBool('cookie_status', false);

      var controller = Get.find<LoginStatusController>();
      log('siliniyor');
      await controller.controller.value.clearLocalStorage();
      await controller.controller.value.clearCache();
      log('silindi');

      return true;
    }

    return false;
  }
}
