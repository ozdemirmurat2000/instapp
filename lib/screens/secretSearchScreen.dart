import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:instapp/widgets/kullaniciAramaWidget.dart';

class SecretSearchScreen extends StatelessWidget {
  const SecretSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 29.h),
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
                    controller: TextEditingController(),
                  ),
                ),
                const AramaSonucKullanici(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AramaSonucKullanici extends StatelessWidget {
  const AramaSonucKullanici({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            // ARANAN KULLANICI AVAR
            Container(
              margin: EdgeInsets.only(
                  top: 10.h, left: 18.w, bottom: 10.h, right: 12.w),
              width: 50.h,
              height: 50.h,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/avatar1.jpg')),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nisa Aşçı',
                  style: KTextStyle.KHeaderTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '@nisaascii.41',
                  style: KTextStyle.KHeaderTextStyle(
                      fontSize: 10.sp, textColor: KColors.textColorMini4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
