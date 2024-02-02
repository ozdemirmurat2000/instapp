import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/screens/splashScreen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

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
  runApp(const MyApp());
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('699512f3-94ec-4560-a594-ef004f8616d2');
  OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

var controller = WebViewController();

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initReferrerDetails();
    getId();
  }

  String _referrerDetails = '';
  var controller = Get.put(LoginStatusController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: controller.loginStatus.value == false
            ? const SplashScreen()
            : const HomeScreen());
  }

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

  Future getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;

      preferences.setString('device_id', '$iosDeviceInfo');
      iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      preferences.setString('device_id', androidDeviceInfo.id);

      androidDeviceInfo.id;
    }
  }
}
