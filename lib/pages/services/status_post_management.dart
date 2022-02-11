import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StatusPostManagement {
  addStatusPost(statusData) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('statusGroupPosts') == null) {
      List newStatusPosts = [];
      newStatusPosts.add(statusData);
      _prefs.setString('statusGroupPosts', json.encode(newStatusPosts));
    } else {
      List newStatusPosts = json.decode(_prefs.getString('statusGroupData')!);
      newStatusPosts.add(statusData);
      _prefs.setString('statusGroupPosts', json.encode(newStatusPosts));
    }
  }

  getStatusPost() async {
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

    if (_prefs.getString('statusGroupData') == null) {
      return 'empty';
    } else {
      return _prefs.getString('statusGroupData');
    }
  }

  updateStatusPost(behavior, bvalue) async {
    // {
    //   'session': value['session'],
    //   'fullname': _reg_fullname,
    //   'username': 'username_12',
    //   'bio': 'Hi there, this is my bio',
    //   'status_count': '0',
    //   'friends_count': '0',
    //   'profilephoto': '',
    //   'interests': '',
    // }

    // new {relationship status, }
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getString('statusGroupData') == null) {
      return 'empty';
    } else {
      //  this is where the magic begins
      //  this is where the magic begins

      Map sessionData = json.decode(_prefs.getString('statusGroupData')!);
      sessionData[behavior] = bvalue;

      String stringsessionData = json.encode(sessionData);
      _prefs.setString('statusGroupData', stringsessionData);
      return 'complete';
    }
  }
}
