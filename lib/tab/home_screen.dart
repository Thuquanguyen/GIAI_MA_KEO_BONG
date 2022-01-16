import 'package:flutter/material.dart';
import 'package:gmsh/handel/message_handler.dart';
import 'package:gmsh/tab/chat_screen.dart';
import 'package:gmsh/tab/forum_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late WebViewController _webViewController;
  bool isShowLoading = false;
  late TabController _tabController;
  int _activeTabIndex = 0;
  bool isAddListener = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_setActiveTabIndex);
    super.initState();
  }

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController.index;
    MessageHandler().notify(EVENT_CHANGE_TAB, data: _tabController.index);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                text: 'DIỄN ĐÀN',
              ),
              Tab(
                text: 'CHAT',
              ),
            ],
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 0),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          ForumScreen(),
          ChatScreen(),
        ],
      ),
    );
  }
}
