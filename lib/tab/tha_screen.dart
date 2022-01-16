import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmsh/constant.dart';
import 'package:gmsh/handel/message_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';


class THAScreen extends StatefulWidget {
  const THAScreen({Key? key}) : super(key: key);

  @override
  _THAScreenState createState() => _THAScreenState();
}

class _THAScreenState extends State<THAScreen> {
  late WebViewController _webViewController;
  bool isShowLoading = false;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    MessageHandler().register(EVENT_PAGE_4, handleAction);
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
    MessageHandler().unregister(EVENT_PAGE_4);
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(color: Colors.blue,);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
            initialUrl: URL_THA,
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
