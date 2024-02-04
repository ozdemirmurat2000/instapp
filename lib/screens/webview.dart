import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/services/Get/getClass.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  WebviewScreen({super.key});

  bool onPageFinished = false;

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) async {
          if (url == 'https://www.instagram.com/' ||
              url == 'https://www.instagram.com/accounts/onetap/?next=%2F') {
            log('webview tetiklendi');

            if (LoginStatusController.webView) {
              return;
            } else {
              Get.offAll(() => const HomeScreen());

              LoginStatusController.webView = true;
            }
          }
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(Uri.parse('https://www.instagram.com/accounts/login/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram giris yap'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
