import 'package:shared_preferences/shared_preferences.dart';

const String URL_FORUM = 'https://giaimakeobong.com/';
const String URL_CHAT = 'https://giaimakeobong.com/chat-vip/';
const String URL_KUDV = 'http://kubet.gmkb.net/';
const String URL_THA = 'http://tha.gmkb.net/';
const String URL_SUPPORT =
    'https://tawk.to/chat/61ab953fc82c976b71bfa46b/1fm33u0f7';

const String EVENT_CHANGE_TAB = 'EVENT_CHANGE_TAB';

const String EVENT_PAGE_0 = 'EVENT_PAGE_0';
const String EVENT_PAGE_1 = 'EVENT_PAGE_1';
const String EVENT_CLICK_PAGE_1 = 'EVENT_CLICK_PAGE_1';
const String EVENT_PAGE_2 = 'EVENT_PAGE_2';
const String EVENT_PAGE_3 = 'EVENT_PAGE_3';
const String EVENT_PAGE_4 = 'EVENT_PAGE_4';

const String CHECK_CLICK = 'CHECK_CLICK';

void saveData(bool isCheck) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(CHECK_CLICK, isCheck);
}

Future<bool?> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(CHECK_CLICK);
}
