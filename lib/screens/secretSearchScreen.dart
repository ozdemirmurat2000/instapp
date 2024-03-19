import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/searchedUserController.dart';
import 'package:instapp/models/searchedUserModel.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:instapp/widgets/kullaniciAramaWidget.dart';

import 'showSecretUsersScreen.dart';

class SecretSearchScreen extends StatefulWidget {
  const SecretSearchScreen({super.key});

  @override
  State<SecretSearchScreen> createState() => _SecretSearchScreenState();
}

class _SecretSearchScreenState extends State<SecretSearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // GetServices.getUserFollowerList();
  }

  TextEditingController controller = TextEditingController();
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

        // APP BAR
        appBar: ScreenDetails.appBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width.w,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Container(
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 21.h),
                    child: Column(
                      children: [
                        Text(
                          'Gizli Profilleri Görüntüle',
                          style: KTextStyle.KHeaderTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            textColor: KColors.textYellowColor,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Gizli profilleri anonim olarak görüntüle!',
                          style: KTextStyle.KHeaderTextStyle(
                            fontSize: 10.sp,
                            textColor: KColors.textColorMini,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 28.h, left: 53.w, right: 52.65.w),
                    child: Image.asset(
                      'assets/images/kullaniciAraBackGround.png',
                      width: 269.w,
                      height: 145.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 13.h),
                    child: KullaniciAramaWidget(
                      textColor: KColors.textYellowColor,
                      controller: controller,
                    ),
                  ),
                  controllerUser.isSearching.value
                      ? Obx(
                          () => Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : Obx(
                          () => ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controllerUser.users.length,
                            itemBuilder: (context, index) {
                              return AramaSonucKullanici(
                                  user: controllerUser.users[index]);
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AramaSonucKullanici extends StatelessWidget {
  AramaSonucKullanici({super.key, required this.user});

  SearchedUser user;

  var controller = Get.find<SearchedUserController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log(controller.userData.value.toString());
        controller.userData.value = null;
        Get.to(ShowSecretUsersScreen(
          userName: user.username ?? '',
        ));
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: 22.w,
          left: 23.w,
          bottom: 10.h,
        ),
        child: Container(
          width: 330.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: KColors.cardColor,
            borderRadius: BorderRadius.circular(
              10.w,
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 10.h, left: 18.w, bottom: 10.h, right: 12.w),
                width: 50.h,
                height: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(user.profilePicUrl ?? '')),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    removeUtf16Characters(kisalt(user.fullName ?? '')),
                    style: KTextStyle.KHeaderTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: KTextStyle.KHeaderTextStyle(
                        fontSize: 10.sp, textColor: KColors.textColorMini4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String kisalt(String metin, {int uzunluk = 28, String kisaltma = "..."}) {
    if (metin.length <= uzunluk) {
      return metin;
    }
    return metin.substring(0, uzunluk) + kisaltma;
  }

  String removeUtf16Characters(String input) {
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      int codeUnit = input.codeUnitAt(i);
      if (codeUnit < 0xD800 || codeUnit > 0xDFFF) {
        buffer.writeCharCode(codeUnit);
      } else if (codeUnit >= 0xD800 &&
          codeUnit <= 0xDBFF &&
          i + 1 < input.length) {
        int nextCodeUnit = input.codeUnitAt(i + 1);
        if (nextCodeUnit >= 0xDC00 && nextCodeUnit <= 0xDFFF) {
          i++;
        }
      }
    }

    return buffer.toString();
  }
}
