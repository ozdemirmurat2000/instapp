import 'dart:developer';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/searchedUserController.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/screens/premiumScreen.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../models/hikayeModel.dart';
import '../services/Get/getClass.dart';
import '../widgets/hikayeWidget.dart';

class ShowSecretUsersScreen extends StatefulWidget {
  ShowSecretUsersScreen({super.key, required this.userName});
  String userName;

  @override
  State<ShowSecretUsersScreen> createState() => _ShowSecretUsersScreenState();
}

class _ShowSecretUsersScreenState extends State<ShowSecretUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.userName);
    fetchUserData();
  }

  bool isLoad = false;

  List<String> randomImgURL = [
    'https://img.freepik.com/free-photo/ginger-head-woman-with-colorful-outfit_23-2149441386.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/stylish-red-haired-woman-playing-with-hairs-posing-pink-lien-dress-with-sleeves-pink_273443-4417.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/portrait-young-happy-woman-studio_1303-13799.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/excellent-smiling-beautiful-woman-showing-okay-ok-zero-sign-approve-smth-good-praising-complimenting-beige-background_1258-88115.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/portrait-young-asian-woman_23-2148932865.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/portrait-young-japanese-woman-with-jacket_23-2148870732.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/male-dancer-posing-sneakers-suit-without-shirt_23-2148417931.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/portrait-handsome-confident-model-sexy-stylish-man-dressed-sweater-jeans-fashion-hipster-male-with-curly-hairstyle-posing-near-blue-wall-studio-isolated_158538-26600.jpg?size=626&ext=jpg',
    'https://img.freepik.com/free-photo/portrait-handsome-fashion-stylish-hipster-model-dressed-warm-red-sweater-posing-studio_158538-11524.jpg?size=626&ext=jpg',
  ];

  Future<bool> fetchUserData() async {
    await GetServices.fetchPostData(widget.userName);

    setState(() {
      isLoad = true;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var userController = Get.put(SearchedUserController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: ScreenDetails.appBar(context),
      body: isLoad == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Obx(
              () => SingleChildScrollView(
                physics: userController.userData.value?.isPrivate ?? false
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
                            child: userCard(context,
                                followerCount: userController
                                        .userData.value?.followerCount ??
                                    '',
                                followingCount: userController
                                        .userData.value?.followedCount ??
                                    '',
                                mediaCount:
                                    userController.userData.value?.mediaCount ??
                                        '',
                                fullName:
                                    userController.userData.value?.fullName ??
                                        '',
                                userName:
                                    userController.userData.value?.userName ??
                                        ''),
                          ),
                          Positioned(
                            child: Padding(
                              padding: EdgeInsets.only(right: 15.0.w),
                              child: HikayeWidget(
                                kullaniciHikaye: HikayeModel(
                                    userImage: userController
                                            .userData.value?.profilePicURL ??
                                        '',
                                    userName: userController
                                            .userData.value?.userName ??
                                        '',
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
                          userController.userData.value?.mediaCount == '0'
                              ? Container(
                                  child: const Text(
                                      'Kullanicinin medyasi bulunmamaktadir'),
                                )
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Blur(
                                    colorOpacity: userController
                                                .userPremiumStatus
                                                .value
                                                .isPremium ==
                                            1
                                        ? 0
                                        : 0.9,
                                    blur: userController.userPremiumStatus.value
                                                .isPremium ==
                                            1
                                        ? 0
                                        : 6,
                                    blurColor: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 22.w, bottom: 9.h),
                                          alignment: Alignment.centerLeft,
                                          child: const Text('Gönderiler'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 22.w),
                                          child: CustomScrollView(
                                            shrinkWrap: true,
                                            primary: false,
                                            slivers: [
                                              SliverGrid.builder(
                                                itemCount: userController
                                                        .userPosts.isEmpty
                                                    ? 9
                                                    : userController
                                                        .userPosts.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 7.w,
                                                  mainAxisSpacing: 7.h,
                                                ),
                                                itemBuilder: (context, index) =>
                                                    userController
                                                            .userPosts.isEmpty
                                                        ? gonderiItem(
                                                            randomImgURL[index])
                                                        : gonderiItem(
                                                            userController
                                                                    .userPosts[
                                                                index]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          userController.userPremiumStatus.value.isPremium == 1
                              ? const SizedBox()
                              : Positioned(
                                  top: 100.w,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.black,
                                        ),
                                        child: Image.asset(
                                            'assets/icons/lock.png'),
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
                                        userController.userPremiumStatus.value
                                                    .isPremium ==
                                                0
                                            ? 'Sadece Vip üyeler bu özelliği kullanabilir.'
                                            : 'Gizli profilleri anonim olarak görüntüle!',
                                        style: KTextStyle.KHeaderTextStyle(
                                            fontSize: 10.sp),
                                      ),
                                      SizedBox(height: 19.h),
                                      GestureDetector(
                                        onTap: () {
                                          if (userController.userPremiumStatus
                                                  .value.isPremium ==
                                              0) {
                                            Get.to(() => PremiumScreen());
                                          }
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            userController.userPremiumStatus
                                                        .value.isPremium ==
                                                    0
                                                ? 'Vip üye ol'
                                                : 'Profili Gör',
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
        image:
            DecorationImage(image: NetworkImage(imageURL), fit: BoxFit.cover),
      ),
    );
  }

  Container userCard(BuildContext context,
      {required String fullName,
      required String userName,
      required String followerCount,
      required String followingCount,
      required String mediaCount}) {
    return Container(
      width: 330.w,
      padding: EdgeInsets.only(top: 45.h),
      height: 146.h,
      margin: EdgeInsets.only(left: 23.w, right: 22.w, top: 10.h),
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
                fullName,
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
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
                buildUserInfo('Takipçi', followerCount),
                buildUserInfo(
                  'Takip edilen',
                  followingCount,
                ),
                buildUserInfo(
                  'Gönderi',
                  mediaCount,
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
