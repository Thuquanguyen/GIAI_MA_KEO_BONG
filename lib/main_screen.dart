import 'package:flutter/material.dart';
import 'package:gmsh/handel/message_handler.dart';
import 'package:gmsh/tab/chat_screen.dart';
import 'package:gmsh/tab/forum_screen.dart';
import 'package:gmsh/tab/kudv_screen.dart';
import 'package:gmsh/tab/support_screen.dart';
import 'package:gmsh/tab/tha_screen.dart';

import 'constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController();

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(icon: Text(''), title: Text('DIỄN ĐÀN')),
    BottomNavigationBarItem(icon: Text(''), title: Text('CHAT')),
    BottomNavigationBarItem(icon: Text(''), title: Text('KUDV')),
    BottomNavigationBarItem(icon: Text(''), title: Text('THA')),
    BottomNavigationBarItem(icon: Text(''), title: Text('HỖ TRỢ')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    MessageHandler().register(EVENT_CHANGE_TAB, handleTabIndex);
    super.initState();
  }

  @override
  void dispose() {
    MessageHandler().unregister(EVENT_CHANGE_TAB);
    super.dispose();
  }

  void handleTabIndex(tabIndex) {
    _selectedTabIndex = tabIndex;
  }

  void pushNotification(String eventName, bool isBack) {
    MessageHandler().notify(eventName, data: isBack);
  }

  void handleAction(bool isBack) {
    print('_selectedIndex = $_selectedIndex');
    switch (_selectedIndex) {
      case 0:
        pushNotification(EVENT_PAGE_0, isBack);
        return;
      case 1:
        pushNotification(EVENT_PAGE_1, isBack);
        return;
      case 2:
        pushNotification(EVENT_PAGE_2, isBack);
        return;
      case 3:
        pushNotification(EVENT_PAGE_3, isBack);
        return;
      case 4:
        pushNotification(EVENT_PAGE_4, isBack);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.red,
            resizeToAvoidBottomInset: false,
            body: Column(children: [
              Expanded(
                  child: Scaffold(
                // resizeToAvoidBottomInset: false,
                bottomNavigationBar: BottomNavigationBar(
                  items: _items,
                  onTap: _onTappedBar,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white54,
                  backgroundColor: const Color.fromRGBO(8, 91, 52, 1),
                  currentIndex: _selectedIndex,
                ),
                body: IndexedStack(
                  index: _selectedIndex,
                  children: const <Widget>[
                    ForumScreen(),
                    ChatScreen(),
                    KUDVScreen(),
                    THAScreen(),
                    SupportScreen(),
                  ],
                ),
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleAction(true);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              'Trở về'.toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handleAction(false);
                      },
                      child: Row(
                        children: [
                          Text(
                            'TIẾP THEO'.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])),
      ),
    );
  }

  Future<void> _onTappedBar(int value) async {
    if (value == 1) {
      bool? isCheck = await getData();
      if(isCheck == false){
        saveData(true);
        MessageHandler().notify(EVENT_CLICK_PAGE_1);
      }
    }
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
