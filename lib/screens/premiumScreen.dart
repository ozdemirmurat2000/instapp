import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/premiumPageController.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/utils/screenDetails.dart';

class PremiumScreen extends StatelessWidget {
  PremiumScreen({super.key});
  var controller = Get.put(PremiumPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/backgroundBlur.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: ScreenDetails.logo(context),
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  'PREMİUM',
                  style: KTextStyle.KHeaderTextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    textColor: KColors.textYellowColor,
                  ),
                ),
              ),
              Container(
                width: 40.h,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      KColors.textColorLinearStart.withOpacity(0.1),
                      KColors.textColorLinearMiddle.withOpacity(0.1),
                      KColors.textColorLinearEnd.withOpacity(0.1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Transform.rotate(
                    angle: 45 * pi / 180,
                    child: MyUtils.maskIcon(Iconsax.add4, 24.w),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              alignment: Alignment.center,
              child: ScreenDetails.divider(context),
            ),
            SizedBox(height: 23.h),
            Text(
              'Gizli Hayranların Kim?',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Senden habersiz profiline kim bakıyor, gizli hayranların kim, kim seni engelledi tüm bu özelliklere ',
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 10.sp,
                        textColor: KColors.textColorMini,
                      ),
                    ),
                    TextSpan(
                      text: 'Premium',
                      style: KTextStyle.KHeaderTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                        textColor: KColors.textYellowColor,
                      ),
                    ),
                    TextSpan(
                      text: '’a geçerek erişebilirsin.',
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 10.sp,
                        textColor: KColors.textColorMini,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.h),
            Container(
              width: 263.w,
              height: 189.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/premiumBackGround.png'),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            BuyCardWidget(
              controller: controller,
              selectIndex: 1,
              iconURL: 'Shape',
              price: '₺104.99',
              text: 'Aylık',
              infoText: 'EN POPÜLER',
              isShowInfoText: true,
            ),
            BuyCardWidget(
              controller: controller,
              selectIndex: 2,
              iconURL: 'Shape2',
              price: '3 Aylık',
              text: 'Aylık',
              infoText: 'AVANTAJLI',
              isShowInfoText: true,
            ),
            BuyCardWidget(
              controller: controller,
              selectIndex: 3,
              iconURL: 'Shape3',
              price: '₺74.99',
              text: 'Haftalık',
            ),
            SizedBox(height: 19.4.h),
            Text(
              'Tüm kilitleri kaldırıp özgürce kullanmaya başla',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                textColor: KColors.textColorMini,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              alignment: Alignment.center,
              width: 330.w,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    KColors.textColorLinearStart,
                    KColors.textColorLinearMiddle,
                    KColors.textColorLinearEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'Satın Al',
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyCardWidget extends StatelessWidget {
  BuyCardWidget({
    super.key,
    required this.iconURL,
    required this.price,
    required this.text,
    this.isShowInfoText = false,
    this.infoText = '',
    required this.selectIndex,
    required this.controller,
  });

  String iconURL;
  String text;
  String price;
  String infoText;
  bool isShowInfoText;
  int selectIndex;
  PremiumPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectedIndex.value = selectIndex;
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          width: 330.w,
          height: 75.h,
          decoration: BoxDecoration(
            border: controller.selectedIndex.value != selectIndex
                ? null
                : GradientBoxBorder(
                    width: 2,
                    gradient: LinearGradient(
                      colors: [
                        KColors.textColorLinearStart,
                        KColors.textColorLinearMiddle,
                        KColors.textColorLinearEnd,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
            borderRadius: BorderRadius.circular(10),
            color: KColors.cardColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.76.w,
                        top: 15.76.h,
                        bottom: 15.76.h,
                        right: 15.76.w),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      width: 43.34.h,
                      height: 43.34.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            KColors.textColorLinearStart.withOpacity(0.2),
                            KColors.textColorLinearMiddle.withOpacity(0.2),
                            KColors.textColorLinearEnd.withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // SATIN ALMA KART IKON
                      //
                      child: Image.asset(
                        'assets/icons/$iconURL.png',
                        width: 19.7.w,
                        height: 23.84.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14.70.h, bottom: 14.70.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        // PAKET ZAMAN TEXT
                        //
                        Text(
                          text,
                          style: KTextStyle.KHeaderTextStyle(
                            fontSize: 13.79.sp,
                            textColor: KColors.textColorMini,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //
                        // URUN FIYAT
                        //
                        Text(
                          price,
                          style: KTextStyle.KHeaderTextStyle(
                            fontSize: 14.78.sp,
                            textColor: const Color(0xFFFAFAFA),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isShowInfoText == false
                  ? const SizedBox()
                  : Container(
                      margin: EdgeInsets.only(right: 19.7.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.88.w),
                        gradient: LinearGradient(
                          colors: [
                            KColors.textColorLinearStart.withOpacity(0.2),
                            KColors.textColorLinearMiddle.withOpacity(0.2),
                            KColors.textColorLinearEnd.withOpacity(0.2),
                          ],
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Text(
                        infoText,
                        style: KTextStyle.KHeaderTextStyle(
                          fontSize: 11.82.sp,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xFFBF09FF),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
