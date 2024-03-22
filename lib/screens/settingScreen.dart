import 'dart:developer';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:instapp/controllers/notification_controller.dart';
import 'package:instapp/controllers/showSnackBarController.dart';
import 'package:instapp/main.dart';
import 'package:instapp/models/hikayeModel.dart';
import 'package:instapp/screens/splashScreen.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:instapp/widgets/hikayeWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen(
      {super.key,
      required this.userFullName,
      required this.userImageUrl,
      required this.userName});

  String userImageUrl;
  String userName;
  String userFullName;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<NotificationStatusController>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: ScreenDetails.appBar(context),
      body: Padding(
        padding: EdgeInsets.only(top: 19.0.h, left: 23.w, right: 22.w),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: ScreenDetails.divider(context),
            ),
            SizedBox(height: 13.h),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ayarlar',
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 13.h),
            Container(
              padding: EdgeInsets.only(
                  left: 16.w, top: 12.h, bottom: 12.h, right: 15.w),
              alignment: Alignment.centerLeft,
              width: 330.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                gradient: LinearGradient(
                  colors: [
                    KColors.textColorLinearStart.withOpacity(0.10),
                    KColors.textColorLinearMiddle.withOpacity(0.10),
                    KColors.textColorLinearEnd.withOpacity(0.10),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // KULLANICI AVATAR

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        width: 50.h,
                        height: 50.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: KColors.textColorLinearMiddle),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100)),
                        child: Container(
                          width: 40.h,
                          height: 40.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(userImageUrl)),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 14.w, top: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userFullName,
                              style: KTextStyle.KHeaderTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                textColor: Colors.white,
                              ),
                            ),
                            Text(
                              '@$userName',
                              style: KTextStyle.KHeaderTextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                textColor: KColors.textColorMini3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  cikisButon(context),
                ],
              ),
            ),
            SizedBox(height: 13.h),
            SettingCard(
              onTap: () {},
              cardText: 'Bildirimler',
              icon: Iconsax.notification5,
              isWidgetShow: true,
              widget: Obx(
                () => Switch(
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF00FF73),
                    value: controller.isAllow.value,
                    onChanged: (value) {
                      controller.isAllow.value = value;
                    }),
              ),
            ),
            SettingCard(
              onTap: () {},
              cardText: 'Dil Tercihi',
              icon: Iconsax.global_edit5,
              isWidgetShow: true,
              widget: const Text('Türkçe'),
            ),
            SettingCard(
              onTap: () {},
              cardText: 'Gizlilik Sözleşmesi',
              icon: Iconsax.note_text5,
              isWidgetShow: false,
            ),
            SettingCard(
              onTap: () {},
              cardText: 'Kullanım Koşulları',
              icon: Iconsax.task_square5,
              isWidgetShow: false,
            ),
            SettingCard(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(10),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            var controller = Get.find<LoginStatusController>();
                            var snackController =
                                Get.put(ShowSnackBarController());

                            var status =
                                await controller.logOutAndDeleteAccount(true);

                            if (status) {
                              Get.offAll(const SplashScreen());
                              snackController.showsnackbar(
                                  context, 'Hesabınız başarıyla silindi.');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: Colors.red[400]),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            child: const Text('Evet'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: Colors.green[400]),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            child: const Text('Hayir'),
                          ),
                        ),
                      ],
                      backgroundColor: KColors.textColorLinearMiddle,
                      content: SizedBox(
                        height: 50.h,
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'Hesabinizi silmek istiyor\nmusunuz?',
                              style: KTextStyle.KHeaderTextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              cardText: 'Hesabımı Sil',
              icon: Iconsax.trash,
              isWidgetShow: false,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector cikisButon(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        var controller = Get.find<LoginStatusController>();
        var snackController = Get.put(ShowSnackBarController());

        var status = await controller.logOutAndDeleteAccount(true);

        if (status) {
          Get.offAll(const SplashScreen());
          snackController.showsnackbar(context, 'Çıkış işlemi başarılı.');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          gradient: LinearGradient(
            colors: [
              KColors.textColorLinearStart,
              KColors.textColorLinearMiddle,
              KColors.textColorLinearEnd
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h, bottom: 11.h),
        child: Text(
          'Çıkış Yap',
          style: KTextStyle.KHeaderTextStyle(
            fontSize: 10.sp,
            textColor: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  SettingCard({
    super.key,
    this.isWidgetShow = false,
    required this.onTap,
    required this.cardText,
    required this.icon,
    this.widget,
  });

  bool isWidgetShow;
  void Function() onTap;
  IconData icon;
  String cardText;
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 9.0.h),
        child: Container(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 13.h, bottom: 12.h),
          width: 330.w,
          height: 80.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: KColors.cardColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50.h,
                    height: 50.h,
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.h),
                      gradient: LinearGradient(
                        colors: [
                          KColors.textColorLinearStart.withOpacity(0.1),
                          KColors.textColorLinearMiddle.withOpacity(0.1),
                          KColors.textColorLinearEnd.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: MyUtils.maskIcon(icon, 24),
                  ),
                  SizedBox(width: 13.w),
                  Text(
                    cardText,
                    style: KTextStyle.KHeaderTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              isWidgetShow ? widget ?? const Text('BUTON') : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
