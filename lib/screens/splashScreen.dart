import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/strings.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BASLIK YAZISI
            baslikYazisi(context),
            // BASLIK ACIKLAMA VE SPLASH GORSEL
            SizedBox(height: 8.h),
            baslikAciklamaYazi(context),

            // UYGULAMA LOGO VE ACIKLAMASI

            uygulamaAdiVeAciklama(context),
            SizedBox(height: 10.h),
            // Buton ve efekti
            butonVeEfekti(context)
          ],
        ),
      ),
    );
  }

  Column butonVeEfekti(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(HomeScreen());
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            height: 70.h,
            width: 330.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  KColors.textColorLinearStart,
                  KColors.textColorLinearMiddle,
                  KColors.textColorLinearEnd
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Text('Giriş Yap',
                style: KTextStyle.KHeaderTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    textColor: Colors.white)),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 80,
          height: 15.h,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: KColors.textColorLinearStart,
            )
          ], borderRadius: BorderRadius.circular(100)),
        ),
      ],
    );
  }

  Stack uygulamaAdiVeAciklama(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/splashScreenBackground.png',
          width: 410.w,
          height: 410.h,
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              // LOGO
              RichText(
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
              ),
              Text(
                'Sana ait hesabın ile giriş yaparak profilini analiz et!',
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 12.sp,
                  textColor: KColors.textColorMini2,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container baslikAciklamaYazi(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: Text(
        textAlign: TextAlign.center,
        KStrings.splashCommentText,
        style: KTextStyle.KHeaderTextStyle(
          fontSize: 12.sp,
          textColor: KColors.textColorMini,
        ),
      ),
    );
  }

  Container baslikYazisi(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GradientText(
        gradientType: GradientType.linear,
        KStrings.splashHeaderText,
        colors: [
          KColors.textColorLinearStart,
          KColors.textColorLinearMiddle,
          KColors.textColorLinearEnd
        ],
        style: KTextStyle.KHeaderTextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
