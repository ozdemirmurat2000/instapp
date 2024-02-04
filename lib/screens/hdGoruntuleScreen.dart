import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:instapp/widgets/kullaniciAramaWidget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HdGoruntuleScreen extends StatelessWidget {
  const HdGoruntuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    controller: TextEditingController(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 23.0.w, right: 22.w),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HDaramSonucWidget(),
                      HDaramSonucWidget(),
                      HDaramSonucWidget(),
                    ],
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
  const HDaramSonucWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90.h,
                height: 90.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/avatar1.jpg')),
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
                    )),
              )
            ],
          ),
          Text(
            'Nisa Aşçı',
            style: KTextStyle.KHeaderTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '@nisaascii.41',
            style: KTextStyle.KHeaderTextStyle(
              fontSize: 10,
              textColor: KColors.textColorMini4,
            ),
          ),
        ],
      ),
    );
  }
}
