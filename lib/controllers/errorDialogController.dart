import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapp/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ErrorDialogs extends GetxController {
  static void gosterHataDialogi() {
    Get.defaultDialog(
      title: "Hata",
      content: const Text('Lutfen tekrar giris yapin'),
      textCancel: "",
      textConfirm: 'Giris yap',
      onConfirm: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

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

        await prefs.setString('current_following_data', saveFollowing);
        await prefs.setString('current_followers_data', saveFollowers);
        await prefs.setBool('following_data_status', saveFollowingStatus);
        await prefs.setBool('followers_data_status', saveFollowersStatus);
        await prefs.setString('following_data_time', saveFollowingDataTime);
        await prefs.setString('followers_data_time', saveFollowersDataTime);
        Get.offAll(const SplashScreen());
      },
    );
  }
}
