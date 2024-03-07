import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/screens/premiumScreen.dart';
import 'package:instapp/utils/iconGradient.dart';

import '../consts/colorsUtil.dart';
import '../consts/textStyle.dart';

class ScreenDetails {
  static Container divider(BuildContext context) {
    return Container(
      width: 330.w,
      height: 1.h,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.5),
        gradient: LinearGradient(
          colors: [
            KColors.textColorLinearStart.withOpacity(0.1),
            KColors.textColorLinearStart,
            KColors.textColorLinearStart.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  static RichText logo(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'XR',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                textColor: KColors.textColorLinearStart,
              )),
          TextSpan(
              text: 'eports',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 16.sp,
                textColor: KColors.textColorLinearMiddle,
              )),
          TextSpan(
            text: '+',
            style: KTextStyle.KHeaderTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              textColor: KColors.textColorLinearEnd,
            ),
          ),
        ],
      ),
    );
  }

  static AppBar appBar(BuildContext context, {bool showCup = false}) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(bottom: 17.h),
        child: logo(context),
      ),
      actions: [
        showCup
            ? GestureDetector(
                onTap: () {
                  Get.to(PremiumScreen());
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.h, right: 22.w),
                  child: const Icon(
                    Iconsax.cup5,
                    color: Color(0xFFFFC700),
                  ),
                ),
              )
            : const SizedBox()
      ],
      leadingWidth: 70.w,
      toolbarHeight: 70.h,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.only(left: 23.w, bottom: 17.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.w),
            gradient: LinearGradient(
              colors: [
                KColors.textColorLinearStart.withOpacity(0.1),
                KColors.textColorLinearMiddle.withOpacity(0.1),
                KColors.textColorLinearEnd.withOpacity(0.1),
              ],
            ),
          ),
          padding: EdgeInsets.all(10.w),
          child: MyUtils.maskIcon(Iconsax.arrow_left_2, 20),
        ),
      ),
    );
  }
}
