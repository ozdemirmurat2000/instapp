import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:instapp/controllers/errorDialogController.dart';
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

    // KULLANICI BILGILERINI AL

    userDataModel.value.media_count = pref.getString('media_count') ?? '';
    userDataModel.value.userName = pref.getString('username') ?? '';
    userDataModel.value.userNameSurname = pref.getString('full_name') ?? '';
    userDataModel.value.userFollowers = pref.getString('follower_count') ?? '';
    userDataModel.value.userFollowed = pref.getString('following_count') ?? '';
    userDataModel.value.userImageURL = pref.getString('profile_pic_url') ?? '';

    // KULLANICI TAKIPCI VE TAKIP EDILEN LISTELERI AL

    // ILK GIRISTEKI VERILER
    String firstFollowersData = pref.getString("first_followers_data") ?? '';
    String firstFollowingData = pref.getString("first_following_data") ?? '';
    // SONRAKI GIRISTEKI VERILER
    String newFollowersData = pref.getString("new_followers_data") ?? '';
    String newFollowingData = pref.getString("new_following_data") ?? '';

    // KULLANICI BILGILERINI KONTROL ET EGER BILGILER  DURMUYORSA HATA DIALOG GOSTER

    if (userDataModel.value.userName.isEmpty ||
        userDataModel.value.userNameSurname.isEmpty ||
        userDataModel.value.userImageURL.isEmpty) {
      // KULLANICI VERILERI BOS
      ErrorDialogs.gosterHataDialogi();
    }
    // BILGILER DURUYORSA KULLANICI TAKIPCI VERILERINI HESAPLA
    else {
      // YENI TAKIPCILERIN VERISINI HESAPLA EGER VERI VARSA

      if (newFollowingData.isEmpty || newFollowersData.isEmpty) {
        // YENI VERI ALINMAMIS BU YUZDEN BURASI BOS GECILECEK
      } else {
        // YENI VERI VAR ESKI VE YENI VERI ILE HESAPLAMA YAP
        var dataNewFollowers = jsonDecode(newFollowersData) as List;
        var dataNewFollowing = jsonDecode(newFollowingData) as List;
        var dataFirstFollowers = jsonDecode(firstFollowersData) as List;
        var dataFirstFollowing = jsonDecode(firstFollowingData) as List;

        List<UserFollowersModel> cnewFollowers = dataNewFollowers
            .map((e) => UserFollowersModel.fromJson(e))
            .toList();
        List<UserFollowingModel> cnewFollowing = dataNewFollowing
            .map((e) => UserFollowingModel.fromJson(e))
            .toList();
        List<UserFollowersModel> cfirstFollowers = dataFirstFollowers
            .map((e) => UserFollowersModel.fromJson(e))
            .toList();
        List<UserFollowingModel> cfirstFollowing = dataFirstFollowing
            .map((e) => UserFollowingModel.fromJson(e))
            .toList();

        // ESKI VE YENI LISTEDEKI TAKIPCILERIMI KARSILASTIR

        // YENI TAKIPCILERI BUL

        for (var newData in cnewFollowers) {
          bool isHave = false;

          for (var firstData in cfirstFollowers) {
            if (newData.pkId == firstData.pkId) {
              isHave = true;
              break;
            }
          }

          if (!isHave) {
            newFollowers.add(newData);
          }
        }
        // KAYBEDILEN TAKIPCILERI BUL

        for (var firstdata in cfirstFollowers) {
          bool isHave = false;
          for (var newData in cnewFollowers) {
            if (firstdata.pkId == newData.pkId) {
              isHave = true;
              break;
            }
          }

          if (!isHave) {
            lostFollowers.add(firstdata);
          }
        }

        // TAKIP ETMEYENLREI BUL

        for (var firstData in cnewFollowing) {
          bool isHave = false;

          for (var newData in cnewFollowers) {
            if (firstData.pkId == newData.pkId) {
              isHave = true;
              break;
            }
          }
          if (!isHave) {
            notFollowing.add(firstData);
          }
        }
        // TAKIP ETMEDIKLERIMI  BUL

        for (var firstData in cnewFollowers) {
          bool isHave = false;

          for (var newData in cnewFollowing) {
            if (firstData.pkId == newData.pkId) {
              isHave = true;
              break;
            }
          }
          if (!isHave) {
            meNotFollowing.add(firstData);
          }
        }
      }
    }

    // TAKIP ETMEYENLERI KONTROL ET
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
