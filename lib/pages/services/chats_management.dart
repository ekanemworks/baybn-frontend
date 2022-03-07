import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatsManagement {
  setChats(momentsData) async {
    momentsData = json.encode(momentsData);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('chatsData', momentsData);
  }

  addChatToChats(chat) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('chatsData') == null) {
      List newChatsData = [];
      newChatsData.add(chat);
      _prefs.setString('chatsData', json.encode(newChatsData));
    } else {
      List newStatusPosts = json.decode(_prefs.getString('chatsData')!);
      newStatusPosts.add(chat);
      _prefs.setString('chatsData', json.encode(newStatusPosts));
    }
  }

  getChats() async {
    // {
    //   'session': value['session'],
    //   'fullname': _reg_fullname,
    //   'username': 'username_12',
    //   'bio': 'Hi there, this is my bio',
    //   'spikestatus_count': '0',
    //   'friends_count': '0',
    //   'photos': '',
    //   'interests': '',
    // }

    // new {relationship status, }
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getString('chatsData') == null) {
      return 'empty';
    } else {
      return _prefs.getString('chatsData');
    }
  }
}
