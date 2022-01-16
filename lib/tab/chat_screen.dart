import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gmsh/constant.dart';
import 'package:gmsh/handel/message_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  // late WebViewController _webViewController;
  late InAppWebViewController _webViewController;
  bool isShowLoading = false;

  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    MessageHandler().register(EVENT_PAGE_1, handleAction);
    MessageHandler().register(EVENT_CLICK_PAGE_1, handleActionClick);
    super.initState();
  }

  void handleActionClick() async{
    bool? isCheck = await getData();
    if(isCheck ?? false){
      setState(() {
        isShowLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 5000), () {
        setState(() {
          print('reload');
          _webViewController.reload();
          isShowLoading = false;
        });
      });
    }
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
    MessageHandler().unregister(EVENT_PAGE_1);
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
          gestureRecognizers: Set()
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
          initialUrlRequest: URLRequest(url: Uri.parse(URL_CHAT)),
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
        // WebView(
        //     initialUrl: URL_CHAT,
        //     javascriptMode: JavascriptMode.unrestricted,
        //     onWebViewCreated: (WebViewController webViewController) {
        //       _webViewController = webViewController;
        //     },
        //     onPageStarted: (a) {
        //       setState(() {
        //         isShowLoading = true;
        //       });
        //     },
        //     onPageFinished: (a) {
        //       setState(() {
        //         isShowLoading = false;
        //       });
        //     }),
        if (isShowLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
