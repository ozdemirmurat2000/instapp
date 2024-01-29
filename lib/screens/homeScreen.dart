import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/models/cardModelDefault.dart';
import 'package:instapp/models/hikayeModel.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/widgets/cardWidgetDefault.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../widgets/cardWidgetMulti.dart';
import '../widgets/hikayeWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CardModelDefault kartDetay = CardModelDefault(
    baslik: 'Profilime Kim Baktı?',
    baslikAciklama: 'Bugün 12 kişi profiline baktı',
    leftIcon: Iconsax.eye4,
  );
  CardModelDefault kartDetay1 = CardModelDefault(
    baslik: 'Hikayeleri Gizli İzle',
    baslikAciklama: 'Hikayelerini izlediğin kişilere gözükmeden izle!',
    leftIcon: Iconsax.ghost5,
  );
  CardModelDefault kartDetay2 = CardModelDefault(
    baslik: 'Beni Engelleyenler',
    baslikAciklama: 'Hesabını kimlerin engellediğini gör!',
    leftIcon: Iconsax.slash4,
  );
  CardModelDefault kartDetay3 = CardModelDefault(
      baslik: 'HD Profil Fotoğrafı',
      baslikAciklama: 'Merak ettiğin profil fotoğraflarını HD gör',
      leftIcon: Iconsax.slash4,
      widget: GradientText(
        'HD',
        colors: [
          KColors.textColorLinearStart,
          KColors.textColorLinearMiddle,
          KColors.textColorLinearEnd
        ],
        gradientType: GradientType.linear,
        style: KTextStyle.KHeaderTextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ));

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
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // HIAKYELERIN GOSTERILDIGI ALAN
              hikayeler(),
              SizedBox(height: 15.h),

              // DIVEDER
              divider(context),
              SizedBox(height: 15.h),

              // KULLANICI KART TAKIPCI, TAKIP EDILEN , GONDERILERIN OLDUGU ALAN

              kullaniciDetayKart(context),

              const SizedBox(height: 15),

              // KULLANICI ARA , GIZLI PROFILLERI GOR KART

              kullaniciAraKart(context),

              //

              CardWidgetDefault(
                kartDetay: kartDetay,
              ),

              CardWidgetMulti(
                  leftIcon: Iconsax.profile_add5,
                  leftText: 'Gelen Takipçiler',
                  leftValueText: '12',
                  rightIcon: Iconsax.profile_remove5,
                  rightText: 'Giden Takipçiler',
                  rightValueText: '15'),

              CardWidgetDefault(
                kartDetay: kartDetay1,
              ),
              CardWidgetDefault(
                kartDetay: kartDetay2,
              ),

              CardWidgetMulti(
                  widget: Image.asset(
                    'assets/icons/unHappyIcon.png',
                    width: 22.w,
                    height: 22.w,
                  ),
                  leftIcon: Iconsax.emoji_sad5,
                  leftText: 'Takip Etmeyenler',
                  leftValueText: '12',
                  rightIcon: Iconsax.dislike5,
                  rightText: 'Takip Etmediklerim',
                  rightValueText: '15'),
              CardWidgetDefault(
                kartDetay: kartDetay3,
              ),

              SizedBox(height: 34.h),
            ],
          ),
        ),
      ),
    );
  }

  Container kullaniciAraKart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: KColors.cardColorDark,
          borderRadius: BorderRadius.circular(10.w)),
      height: 109.h,
      margin: EdgeInsets.symmetric(horizontal: 22.w),
      width: 330.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ICON,BASLIK,ACIKLAMA
                Padding(
                  padding: EdgeInsets.only(top: 18.w, bottom: 3.w),
                  child:
                      Image.asset('assets/icons/kullaniciAraAnahtarIcon.png'),
                ),
                // BASLIK

                Text(
                  'Gizli Profilleri Gör',
                  style: KTextStyle.KHeaderTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    textColor: KColors.textYellowColor,
                  ),
                ),
                // ACIKLAMA

                Text(
                  'Gizli profilleri anonim\nolarak görüntüle!',
                  style: KTextStyle.KHeaderTextStyle(
                    fontSize: 10.sp,
                    textColor: KColors.textColorMini,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w, top: 10.w, bottom: 11.w),
            child: Image.asset(
              'assets/images/kullaniciAraBackGround.png',
              width: 164.w,
              height: 90.h,
            ),
          ),
        ],
      ),
    );
  }

  Container divider(BuildContext context) {
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

  Container kullaniciDetayKart(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.w),
      width: MediaQuery.of(context).size.width.w,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: KColors.textColorLinearEnd.withOpacity(0.1),
            ),
            width: 290.w,
            height: 110.h,
            child: Container(
              margin: EdgeInsets.only(left: 75.w, top: 5.w, bottom: 5.w),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aslı Tandoğan',
                          style: KTextStyle.KHeaderTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            textColor: Colors.white,
                          ),
                        ),
                        Text(
                          '@aslitandogan',
                          style: KTextStyle.KHeaderTextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            textColor: KColors.textColorMini3,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Container(
                          margin: EdgeInsets.only(right: 27.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              kullaniciDetayCard('Takipçi', '24K', context),
                              kullaniciDetayCard(
                                  'Takip edilen', '1.2K', context),
                              kullaniciDetayCard('Gönderi', '329', context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // KULLANICI AVATAR
          Positioned(
              left: 15.w,
              child: HikayeWidget(
                  kullaniciHikaye: HikayeModel(
                      size: 80.w,
                      isShowName: false,
                      userImage: 'assets/images/avatar2.jpg',
                      userName: 'asd')))
        ],
      ),
    );
  }

  Column kullaniciDetayCard(
      String baslik, String baslikAciklama, BuildContext context) {
    return Column(
      children: [
        // TAKIPCI BASLIK
        //
        Text(
          baslik,
          style: KTextStyle.KHeaderTextStyle(
            fontSize: 10.sp,
            textColor: KColors.textColorMini,
          ),
        ),

        //TAKIPCI SAYISI
        Text(
          baslikAciklama,
          style: KTextStyle.KHeaderTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              textColor: Colors.white),
        ),
      ],
    );
  }

  Padding hikayeler() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            HikayeWidget(
                kullaniciHikaye: HikayeModel(
                    isCover: true,
                    userImage: 'assets/icons/anonimEyeIcon.png',
                    userName: 'Anonim Izle')),
            HikayeWidget(
                kullaniciHikaye: HikayeModel(
                    userImage: 'assets/images/avatar1.jpg',
                    userName: 'farukkoc')),
            HikayeWidget(
                kullaniciHikaye: HikayeModel(
                    userImage: 'assets/images/avatar3.jpg',
                    userName: 'dennislive')),
            HikayeWidget(
                kullaniciHikaye: HikayeModel(
                    userImage: 'assets/images/avatar4.jpg',
                    userName: 'sinemdmr')),
            HikayeWidget(
                kullaniciHikaye: HikayeModel(
                    userImage: 'assets/images/avatar5.jpg',
                    userName: 'yandanyandan')),
            HikayeWidget(
                kullaniciHikaye: HikayeModel(
                    userImage: 'assets/images/avatar6.jpg',
                    userName: 'amanaman')),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      // AYARLARIN OLDUGU KISIM
      backgroundColor: Colors.transparent,
      leading: MyUtils.maskIcon(Iconsax.setting_25, 24),

      // BASARIMLARIN OLDUGU KISIM
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 30.0.w),
          child: MyUtils.maskIcon(Iconsax.cup5, 24,
              color: const Color(0xFFFFC700)),
        ),
      ],
    );
  }
}
