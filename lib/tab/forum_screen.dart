import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gmsh/handel/message_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen>
    with AutomaticKeepAliveClientMixin {
  late InAppWebViewController _webViewController;
  bool isShowLoading = false;

  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    MessageHandler().register(EVENT_PAGE_0, handleAction);
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
    MessageHandler().unregister(EVENT_PAGE_0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
          javaScriptCanOpenWindowsAutomatically: true,
          useShouldInterceptFetchRequest: true,
        ),
        android: AndroidInAppWebViewOptions(
          useShouldInterceptRequest: true,
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));

    return Stack(
      children: [
        InAppWebView(
          gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
          initialUrlRequest: URLRequest(url: Uri.parse(URL_FORUM)),
          initialOptions: options,
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onLoadStart: (controller, url) async {
            setState(() {
              isShowLoading = true;
            });
          },
          onLoadStop: (controller, url) async {
            setState(() {
              isShowLoading = false;
            });
          },
        ),
        if (isShowLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
