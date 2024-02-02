import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapp/screens/homeScreen.dart';
import 'package:instapp/services/getCookies.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
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
            Get.offAll(const HomeScreen());
          }
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    )
    ..loadRequest(Uri.parse('https://www.instagram.com/accounts/login/'));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
