import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:lottie/lottie.dart';

class ShowSnackBarController extends GetxController {
  showsnackbar(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/icons/successLottie.json',
                  width: 300.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  message,
                  style: KTextStyle.KHeaderTextStyle(
                      fontSize: 22.sp,
                      textColor: KColors.textColorLinearMiddle,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1500), () => Get.back());
  }
}
