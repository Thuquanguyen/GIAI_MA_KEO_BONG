import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmsh/constant.dart';
import 'package:gmsh/handel/message_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
class KUDVScreen extends StatefulWidget {
  const KUDVScreen({Key? key}) : super(key: key);

  @override
  _KUDVScreenState createState() => _KUDVScreenState();
}

class _KUDVScreenState extends State<KUDVScreen> {
  late WebViewController _webViewController;
  bool isShowLoading = false;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    MessageHandler().register(EVENT_PAGE_2, handleAction);
    super.initState();
  }

  void handleAction(isNext) {
    if (isNext) {
      _webViewController.goBack();
    } else {
      _webViewController.goForward();
    }
  }

  @override
  void dispose() {
    MessageHandler().unregister(EVENT_PAGE_2);
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(color: Colors.grey,);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
            initialUrl: Uri.encodeFull(URL_KUDV),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
            onPageStarted: (a) {
              setState(() {
                isShowLoading = true;
              });
            },
            onPageFinished: (a) {
              setState(() {
                isShowLoading = false;
              });
            }),
        if (isShowLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
      ],
    );
  }
}
