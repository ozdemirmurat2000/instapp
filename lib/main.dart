import 'dart:developer';
import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/screens/splashScreen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'screens/premiumScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  late final PlatformWebViewControllerCreationParams params;
  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    params = WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    );
  } else {
    params = const PlatformWebViewControllerCreationParams();
  }

  final WebViewController controller =
      WebViewController.fromPlatformCreationParams(params);
// ···
  if (controller.platform is AndroidWebViewController) {
    AndroidWebViewController.enableDebugging(true);
    (controller.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
  }
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('699512f3-94ec-4560-a594-ef004f8616d2');
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

var _controller = WebViewController();

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initReferrerDetails();
    checkLoginStatus();
  }

  bool loginStatus = false;

  checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginStatus = pref.getBool('cookie_status') ?? false;
  }

  String _referrerDetails = '';

  @override
  Widget build(BuildContext context) {
    log('$loginStatus');
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              snackBarTheme: SnackBarThemeData(
                contentTextStyle: KTextStyle.KHeaderTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.white),
              ),
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: loginStatus ? const HomeScreen() : const SplashScreen());
  }

//  PremiumScreen());

  Future<void> initReferrerDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String referrerDetailsString;
    try {
      ReferrerDetails referrerDetails =
          await AndroidPlayInstallReferrer.installReferrer;

      referrerDetailsString = referrerDetails.toString();

      preferences.setString('referrer', referrerDetailsString);
    } catch (e) {
      referrerDetailsString = 'Failed to get referrer details: $e';
    }

    if (!mounted) return;

    setState(() {
      _referrerDetails = referrerDetailsString;
    });
  }
}
