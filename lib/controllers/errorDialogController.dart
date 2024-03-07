import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapp/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'loginStatusController.dart';

class ErrorDialogs extends GetxController {
  static void gosterHataDialogi() {
    var controller = WebViewController().obs;

    Get.defaultDialog(
      backgroundColor: Colors.black,
      barrierDismissible: false,
      title: "Hata",
      content: const Text('Lutfen tekrar giris yapin'),
      textConfirm: 'Giris yap',
      onConfirm: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String saveFollowing = prefs.getString('current_followers_data') ?? '';
        String saveFollowers = prefs.getString('current_following_data') ?? '';

        bool saveFollowingStatus =
            prefs.getBool('following_data_status') ?? false;
        bool saveFollowersStatus =
            prefs.getBool('followers_data_status') ?? false;
        await prefs.clear();

        await prefs.setString('current_following_data', saveFollowing);
        await prefs.setString('current_followers_data', saveFollowers);
        await prefs.setBool('following_data_status', saveFollowingStatus);
        await prefs.setBool('followers_data_status', saveFollowersStatus);
        final cookieManager = WebviewCookieManager();
        await cookieManager.clearCookies();
        await prefs.setBool('cookie_status', false);

        var controller = Get.find<LoginStatusController>();
        log('siliniyor');
        await controller.controller.value.clearLocalStorage();
        await controller.controller.value.clearCache();
        log('silindi');
        Get.offAll(
          const SplashScreen(),
        );
      },
    );
  }
}
