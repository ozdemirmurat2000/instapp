import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/errorDialogController.dart';
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:instapp/controllers/notification_controller.dart';
import 'package:instapp/controllers/usersStoriesController.dart';
import 'package:instapp/models/cardModelDefault.dart';
import 'package:instapp/models/hikayeModel.dart';
import 'package:instapp/models/storyModel.dart';
import 'package:instapp/models/userDataModel.dart';
import 'package:instapp/screens/hdGoruntuleScreen.dart';
import 'package:instapp/screens/lostFollowersScreen.dart';
import 'package:instapp/screens/newFollowersScreen.dart';
import 'package:instapp/screens/premiumScreen.dart';
import 'package:instapp/screens/searcUserHistoryScreen.dart';
import 'package:instapp/screens/secretSearchScreen.dart';
import 'package:instapp/screens/settingScreen.dart';
import 'package:instapp/screens/storyScreen.dart';
import 'package:instapp/services/Get/fetch_cookies.dart';
import 'package:instapp/services/Get/fetch_user_followers_data.dart';
import 'package:instapp/services/Get/fetch_user_following_data.dart';
import 'package:instapp/services/Get/fetch_user_info.dart';
import 'package:instapp/services/Get/fetch_user_stories.dart';
import 'package:instapp/services/Post/post_user_data_status.dart';
import 'package:instapp/services/Post/post_user_following_data.dart';
import 'package:instapp/services/Post/post_user_info.dart';
import 'package:instapp/utils/iconGradient.dart';
import 'package:instapp/widgets/cardWidgetDefault.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/widgets/showDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../widgets/cardWidgetMulti.dart';
import '../widgets/hikayeWidget.dart';
import 'meNotFollowingScreen.dart';
import 'notFollowingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final _notificationController = Get.put(NotificationStatusController());

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status == PermissionStatus.granted) {
      _notificationController.isAllow.value = true;
    } else {
      _notificationController.isAllow.value = false;
    }

    log("bildiirm durumu $status");
  }

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();

    startService();

    Future.delayed(const Duration(seconds: 30), () {
      showMyDialog(context);
    });
  }

  startService() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool cookieStatus = pref.getBool('cookie_status') ?? false;
    bool userFollowingStatus = pref.getBool('following_data_status') ?? false;
    bool userFollowerStatus = pref.getBool('followers_data_status') ?? false;

    // CEREZ ALINDIYSA DEVAM ET

    if (!cookieStatus) {
      log("1");
      if (await fetchCookies()) {
        log("2");

        // KULLANICININ BILGILERINI AL HATA VARSA GIRIS EKRANINA GERI DON
        if (!await fetchUserInfo()) {
          log("3");

          ErrorDialogs.gosterHataDialogi();
          return false;
        }
        // KULLANICILARIN HIKAYESINI AL HATA VARSA GIRIS EKRANINA GERI DON
        if (!await fetchUserStories()) {
          ErrorDialogs.gosterHataDialogi();
          return false;
        }
        // KULLANICININ TAKIP ETTIKLERININ VERISINI AL HATA VARSA GIRIS EKRANINA DON
        if (!userFollowingStatus) {
          if (!await fetchUserFollowingData()) {
            ErrorDialogs.gosterHataDialogi();
            return false;
          }
        }
        // KULLANICININ TAKIPCILERININ VERISINI AL HATA VARSA GIRIS EKRANINA DON
        if (!userFollowerStatus) {
          if (!await fetchUserFollowersData()) {
            ErrorDialogs.gosterHataDialogi();
            return false;
          }
        }
        // KULLANICININ CEREZ BILGILERINI VERI TABANINA GONDER HATA GIRIS EKRANINA DON
        if (!await postUserInfo()) {
          ErrorDialogs.gosterHataDialogi();
          return false;
        }

        // KULLANICININ ILK GIRIS BILGILERINI VERI TABANINA GONDER [DAHA ONCE LOGIN OLUNDUYSA BURASI ATLANACAK]
        if (!await postUserDataStatus()) {
          ErrorDialogs.gosterHataDialogi();
          return false;
        }
        // KULLANICININ TAKIP ETTIKLERININ VERISINI VERI TABANINA GONDER HATA OLURSA GIRIS EKRANINA DON
        if (!await postUserFollowingData()) {
          ErrorDialogs.gosterHataDialogi();
          return false;
        }
        controller.loginStatus.value = true;
        controller.checkStatus();
      }
    } else {
      log("11");

      if (!await fetchUserStories()) {
        ErrorDialogs.gosterHataDialogi();
        return false;
      }
      if (!await fetchUserFollowersData()) {
        ErrorDialogs.gosterHataDialogi();
        return false;
      }
      if (!await fetchUserFollowingData()) {
        ErrorDialogs.gosterHataDialogi();
        return false;
      }
      controller.loginStatus.value = true;
      controller.checkStatus();
    }
  }

  var controller = Get.put(LoginStatusController());
  var storiesController = Get.put(UserStoriesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroundBlur.png'))),
      child: Obx(
        () => Scaffold(
          backgroundColor: Colors.black.withOpacity(0.1),

          // APP BAR
          appBar: AppBar(
            // AYARLARIN OLDUGU KISIM
            backgroundColor: Colors.transparent,
            leading: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: controller.loginStatus.value == false
                  ? null
                  : () {
                      Get.to(SettingScreen(
                        userFullName:
                            controller.userDataModel.value.userNameSurname,
                        userImageUrl:
                            controller.userDataModel.value.userImageURL,
                        userName: controller.userDataModel.value.userName,
                      ));
                    },
              child: MyUtils.maskIcon(Iconsax.setting_25, 24),
            ),

            // PREMIUM SAYFASI
            actions: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: controller.loginStatus.value == false
                    ? null
                    : () {
                        Get.to(
                          PremiumScreen(),
                        );
                      },
                child: Padding(
                  padding: EdgeInsets.only(right: 30.0.w),
                  child: MyUtils.maskIcon(Iconsax.cup5, 24,
                      color: const Color(0xFFFFC700)),
                ),
              ),
            ],
          ),
          body: controller.loginStatus.value == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // HIAKYELERIN GOSTERILDIGI ALAN
                      hikayeler(storiesController.instagramReels),
                      SizedBox(height: 15.h),

                      // DIVEDER
                      divider(context),
                      SizedBox(height: 15.h),

                      // KULLANICI KART TAKIPCI, TAKIP EDILEN , GONDERILERIN OLDUGU ALAN

                      kullaniciDetayKart(
                          context, controller.userDataModel.value),

                      const SizedBox(height: 15),

                      // KULLANICI ARA , GIZLI PROFILLERI GOR KART

                      kullaniciAraKart(context),

                      // PROFILIME KIM BAKTI WIDGET

                      CardWidgetDefault(
                        onTap: () {},
                        kartDetay: kartDetay,
                      ),

                      CardWidgetMulti(
                        leftOnTap: () {
                          Get.to(NewFollowersScreen());
                        },
                        rightOnTap: () {
                          Get.to(LostFollowersScreen());
                        },
                        leftIcon: Iconsax.profile_add5,
                        leftText: 'Gelen Takipçiler',
                        leftValueText:
                            controller.newFollowers.length.toString(),
                        rightIcon: Iconsax.profile_remove5,
                        rightText: 'Giden Takipçiler',
                        rightValueText:
                            controller.lostFollowers.length.toString(),
                      ),

                      CardWidgetDefault(
                        onTap: () {
                          Get.to(() => const SearchUserHistoryScreen());
                        },
                        kartDetay: kartDetay1,
                      ),
                      CardWidgetDefault(
                        onTap: () {},
                        kartDetay: kartDetay2,
                      ),

                      CardWidgetMulti(
                          leftOnTap: () {
                            Get.to(() => NotFollowingScreen());
                          },
                          rightOnTap: () {
                            Get.to(() => MeNotFollowingScreen());
                          },
                          widget: Image.asset(
                            'assets/icons/unHappyIcon.png',
                            width: 22.w,
                            height: 22.w,
                          ),
                          leftIcon: Iconsax.emoji_sad5,
                          leftText: 'Takip Etmeyenler',
                          leftValueText:
                              controller.notFollowing.length.toString(),
                          rightIcon: Iconsax.dislike5,
                          rightText: 'Takip Etmediklerim',
                          rightValueText:
                              controller.meNotFollowing.length.toString()),
                      CardWidgetDefault(
                        onTap: () => Get.to(HdGoruntuleScreen()),
                        kartDetay: kartDetay3,
                      ),

                      SizedBox(height: 34.h),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

GestureDetector kullaniciAraKart(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Get.to(const SecretSearchScreen());
    },
    child: Container(
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

Container kullaniciDetayKart(
    BuildContext context, UserDataModel? userDataModel) {
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
                        userDataModel!.userNameSurname == ''
                            ? 'Kullanici adini belirtmemis'
                            : userDataModel.userNameSurname,
                        style: KTextStyle.KHeaderTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          textColor: Colors.white,
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
                      SizedBox(height: 13.h),
                      Container(
                        margin: EdgeInsets.only(right: 27.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            kullaniciDetayCard('Takipçi',
                                userDataModel.userFollowers, context),
                            kullaniciDetayCard('Takip edilen',
                                userDataModel.userFollowed, context),
                            kullaniciDetayCard(
                                'Gönderi', userDataModel.media_count, context),
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
                    userImage: userDataModel.userImageURL,
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

Widget hikayeler(List<InstagramReel> reels) {
  return Padding(
    padding: EdgeInsets.only(top: 21.0.h),
    child: SizedBox(
      height: 80.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: reels.length + 1,
        itemBuilder: (context, index) {
          var deneme;
          if (index == 0) {
            return HikayeWidget(
              isBold: true,
              kullaniciHikaye: HikayeModel(
                userImage:
                    deneme == null ? 'assets/icons/anonimEyeIcon.png' : null,
                userName: 'Anonim izle',
                isCover: true,
              ),
            );
          } else {
            return GestureDetector(
              onTap: () async {
                Get.to(StoryScreen(
                  userId: reels[index - 1].id,
                ));

                /// KULLANICI HIKAYESINI GOSTER
                ///
              },
              child: HikayeWidget(
                kullaniciHikaye: HikayeModel(
                  userImage: reels[index - 1].user.profilePicUrl ??
                      'assets/default.jpg',
                  userName: kisalt(reels[index - 1].user.username),
                ),
              ),
            );
          }
        },
      ),
    ),
  );
}

String kisalt(String metin, {int uzunluk = 8, String kisaltma = "..."}) {
  if (metin.length <= uzunluk) {
    return metin;
  }
  return metin.substring(0, uzunluk) + kisaltma;
}
