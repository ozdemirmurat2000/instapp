import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:instapp/models/userDataModel.dart';
import 'package:instapp/models/userFollowersModel.dart';
import 'package:instapp/models/userFollowingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginStatusController extends GetxController {
  RxBool loginStatus = false.obs;
  static bool webView = false;

  var controller = WebViewController().obs;

  var userDataModel = UserDataModel().obs;
  RxList<UserFollowersModel> newFollowers = <UserFollowersModel>[].obs;
  RxList<UserFollowersModel> lostFollowers = <UserFollowersModel>[].obs;

  // Takip etmeyenler

  RxList<UserFollowingModel> notFollowing = <UserFollowingModel>[].obs;
  // Takip etmediklerim

  RxList<UserFollowersModel> meNotFollowing = <UserFollowersModel>[].obs;

  Future checkStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    userDataModel.value.media_count = pref.getString('media_count') ?? '';
    userDataModel.value.userName = pref.getString('username') ?? '';
    userDataModel.value.userNameSurname = pref.getString('full_name') ?? '';
    userDataModel.value.userFollowers = pref.getString('follower_count') ?? '';
    userDataModel.value.userFollowed = pref.getString('following_count') ?? '';
    userDataModel.value.userImageURL = pref.getString('profile_pic_url') ?? '';
    String dataFolowers = pref.getString('current_followers_data') ?? '';
    String newDataFolowing = pref.getString('new_following_data') ?? '';
    String newDataFolowers = pref.getString('new_followers_data') ?? '';
    final followersList = jsonDecode(dataFolowers) as List<dynamic>;
    final newFollowingList = jsonDecode(newDataFolowing) as List<dynamic>;
    final newFollowersList = jsonDecode(newDataFolowers) as List<dynamic>;

    log(pref.getString('follower_count') ?? '');

    final userFollowersModel =
        followersList.map((item) => UserFollowersModel.fromJson(item)).toList();
    final newUserFollowingModel = newFollowingList
        .map((item) => UserFollowingModel.fromJson(item))
        .toList();
    final newUserFollowersModel = newFollowersList
        .map((item) => UserFollowersModel.fromJson(item))
        .toList();

    bool checkFollowers =
        newUserFollowersModel.length > userFollowersModel.length ? true : false;

    for (var element
        in checkFollowers ? newUserFollowersModel : userFollowersModel) {
      bool isHave = false;

      for (var el
          in checkFollowers ? newUserFollowersModel : userFollowersModel) {
        if (element.pkId == el.pkId) {
          isHave = true;
          break;
        }
      }
      if (!isHave) {
        if (checkFollowers) {
          newFollowers.add(element);
        } else {
          lostFollowers.add(element);
        }
      }
    }

    // TAKIP ETMEYENLERI KONTROL ET

    for (var element in newUserFollowingModel) {
      bool isHave = false;
      for (var el in newUserFollowersModel) {
        if (element.pkId == el.pkId) {
          isHave = true;
          break;
        }
      }

      if (!isHave) {
        notFollowing.add(element);
      }
    }
    log(notFollowing.length.toString());
    for (var element in newUserFollowersModel) {
      bool isHave = false;

      for (var el in newUserFollowingModel) {
        if (element.username == el.username) {
          isHave = true;
          break;
        }
      }

      if (!isHave) {
        meNotFollowing.add(element);
      }
    }
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

      await prefs.clear();
      await prefs.setString('device_id', saveDeviceID);

      await prefs.setString('current_following_data', saveFollowing);
      await prefs.setString('current_followers_data', saveFollowers);
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
