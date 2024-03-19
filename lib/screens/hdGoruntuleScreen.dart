import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/searchedUserController.dart';
import 'package:instapp/services/Get/fetch_searched_user_data.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:instapp/widgets/kullaniciAramaWidget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../models/searchedUserModel.dart';

class HdGoruntuleScreen extends StatelessWidget {
  HdGoruntuleScreen({super.key});

  TextEditingController tcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controllerUser = Get.put(SearchedUserController());

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundBlur.png'))),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.1),
        appBar: ScreenDetails.appBar(context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width.w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 29.h),
                  child: ScreenDetails.divider(context),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 21.h, left: 79.w, right: 76.w),
                  child: Column(
                    children: [
                      GradientText(
                        'HD Görüntüle',
                        style: KTextStyle.KHeaderTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        gradientType: GradientType.linear,
                        colors: [
                          KColors.textColorLinearStart,
                          KColors.textColorLinearMiddle,
                          KColors.textColorLinearEnd,
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Profil resimlerini HD görüntüle ve indir!',
                        style: KTextStyle.KHeaderTextStyle(
                          fontSize: 10.sp,
                          textColor: KColors.textColorMini,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 86.w,
                    right: 85.w,
                    top: 13.h,
                    bottom: 13.h,
                  ),
                  child: Image.asset(
                    'assets/images/hdGoruntuleBackground.png',
                    width: 204.w,
                    height: 204.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 23.0.h),
                  child: KullaniciAramaWidget(
                    textColor: KColors.textColorMini,
                    controller: tcontroller,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controllerUser.users.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisSpacing: 20.h),
                    itemBuilder: (context, index) {
                      return HDaramSonucWidget(
                          user: controllerUser.users[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HDaramSonucWidget extends StatelessWidget {
  HDaramSonucWidget({super.key, required this.user});
  SearchedUser user;

  var controller = Get.find<SearchedUserController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            log(controller.userData.value?.profilePicURLHD ?? '');

            return FutureBuilder(
              future: fetchSearchedUserData(user.username!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return showUserImage(user.profilePicUrl!);
                } else if (controller.userData.value?.profilePicURLHD != null) {
                  return showUserImage(
                      controller.userData.value!.profilePicURLHD);
                }

                return showUserImage(user.profilePicUrl!);
              },
            );
          },
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90.h,
                height: 90.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(user.profilePicUrl!)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 24.h,
                  height: 24.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        KColors.textColorLinearStart,
                        KColors.textColorLinearMiddle,
                        KColors.textColorLinearEnd,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    border: Border.all(
                      width: 2.w,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'HD',
                    style: KTextStyle.KHeaderTextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            kisalt(user.fullName ?? '', 16),
            style: KTextStyle.KHeaderTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              '@${user.username}',
              style: KTextStyle.KHeaderTextStyle(
                fontSize: 10,
                textColor: KColors.textColorMini4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container showUserImage(String imgURL) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 100.h,
        horizontal: 30.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imgURL),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                "Kapat",
                style: KTextStyle.KHeaderTextStyle(
                    fontSize: 18.sp, textColor: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }

  String kisalt(String metin, int uzunluk) {
    return metin.length <= uzunluk
        ? metin
        : '${metin.substring(0, uzunluk)}...';
  }
}
