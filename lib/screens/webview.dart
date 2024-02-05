import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapp/controllers/loginStatusController.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/services/Get/getClass.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool onPageFinished = false;

  var controller = Get.put(LoginStatusController());

  webviewStart(WebViewController controller) async {
    controller
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

              if (onPageFinished) {
                return;
              } else {
                Get.offAll(() => const HomeScreen());

                onPageFinished = true;
              }
            }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://www.instagram.com/accounts/login/'));
  }

  @override
  void initState() {
    super.initState();
    webviewStart(controller.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram giris yap'),
      ),
      body: WebViewWidget(
        controller: controller.controller.value,
      ),
    );
  }
}
