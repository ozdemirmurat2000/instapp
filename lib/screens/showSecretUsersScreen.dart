import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/showSecretUserController.dart';
import 'package:instapp/models/hikayeModel.dart';
import 'package:instapp/models/userDataModel.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:instapp/widgets/hikayeWidget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ShowSecretUsersScreen extends StatelessWidget {
  ShowSecretUsersScreen({super.key, required this.userDataModel});

  UserDataModel userDataModel;
  List assets = [
    'assets/images/avatar1.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/avatar3.jpg',
    'assets/images/avatar1.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/avatar3.jpg',
    'assets/images/avatar1.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/avatar3.jpg',
    'assets/images/avatar1.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/avatar3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ShowSecretUserController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: ScreenDetails.appBar(context),
      body: Obx(
        () => SingleChildScrollView(
          physics: !controller.isShow.value
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 17.h),
              Container(
                alignment: Alignment.center,
                child: ScreenDetails.divider(context),
              ),

              // USER AVATAR
              SizedBox(height: 57.h),

              SizedBox(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 40.h,
                      child: userCard(context),
                    ),
                    Positioned(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0.w),
                        child: HikayeWidget(
                          kullaniciHikaye: HikayeModel(
                              userImage: userDataModel.userImageURL,
                              userName: userDataModel.userName,
                              isShowName: false,
                              size: 80.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Blur(
                        colorOpacity: controller.isShow.value ? 0 : 0.9,
                        blur: controller.isShow.value ? 0 : 6,
                        blurColor: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 22.w, bottom: 9.h),
                              alignment: Alignment.centerLeft,
                              child: const Text('Gönderiler'),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: CustomScrollView(
                                shrinkWrap: true,
                                primary: false,
                                slivers: [
                                  SliverGrid.builder(
                                    itemCount: assets.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 7.w,
                                      mainAxisSpacing: 7.h,
                                    ),
                                    itemBuilder: (context, index) =>
                                        gonderiItem(assets[index]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 9.h),
                            // GridView.builder(
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   scrollDirection: Axis.vertical,
                            //   shrinkWrap: true,
                            //   itemCount: assets.length,
                            //   gridDelegate:
                            //       SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisSpacing: 7.h,
                            //           mainAxisSpacing: 7.w,
                            //           crossAxisCount: 3),
                            //   itemBuilder: (context, index) =>
                            //       gonderiItem(assets[index]),
                            // )
                          ],
                        ),
                      ),
                    ),
                    controller.isShow.value
                        ? const SizedBox()
                        : Positioned.fill(
                            top: 100.w,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black,
                                  ),
                                  child: Image.asset('assets/icons/lock.png'),
                                ),
                                SizedBox(height: 9.h),
                                GradientText(
                                  'Gizli Profilleri Gör',
                                  colors: [
                                    KColors.textColorLinearStart,
                                    KColors.textColorLinearMiddle,
                                    KColors.textColorLinearEnd,
                                  ],
                                  style: KTextStyle.KHeaderTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Gizli profilleri anonim olarak görüntüle!',
                                  style: KTextStyle.KHeaderTextStyle(
                                      fontSize: 10.sp),
                                ),
                                SizedBox(height: 19.h),
                                GestureDetector(
                                  onTap: () {
                                    controller.isShow.value = true;
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 330.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          KColors.textColorLinearStart,
                                          KColors.textColorLinearMiddle,
                                          KColors.textColorLinearEnd,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Profili Gör',
                                      style: KTextStyle.KHeaderTextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container gonderiItem(String imageURL) {
    return Container(
      width: 105.w,
      height: 105.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(image: AssetImage(imageURL), fit: BoxFit.cover),
      ),
    );
  }

  Container userCard(BuildContext context) {
    return Container(
      width: 330.w,
      padding: EdgeInsets.only(top: 45.h),
      height: 146.h,
      margin: EdgeInsets.only(
        left: 23.w,
        right: 22.w,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              KColors.textColorLinearStart.withOpacity(0.1),
              KColors.textColorLinearMiddle.withOpacity(0.1),
              KColors.textColorLinearEnd.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(10.h)),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                userDataModel.userNameSurname,
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '@${userDataModel.userName}',
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  textColor: KColors.textColorMini3,
                ),
              ),
              SizedBox(height: 9.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: divider(context),
              )
            ],
          ),
          SizedBox(height: 9.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildUserInfo(
                  'Takipçi',
                  userDataModel.userFollowers,
                ),
                buildUserInfo(
                  'Takip edilen',
                  userDataModel.userFollowed,
                ),
                buildUserInfo(
                  'Gönderi',
                  userDataModel.media_count,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildUserInfo(String header, String value) {
    return Column(
      children: [
        Text(
          header,
          style: KTextStyle.KHeaderTextStyle(
            fontSize: 10,
            textColor: KColors.textColorMini,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          style: KTextStyle.KHeaderTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
