import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionManagement {
  checkSession() {}

  setSession(sessionData) async {
    sessionData = json.encode(sessionData);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('sessionGroupData', sessionData);
  }

  getSession() async {
    // {
    //   'id': value['id'],
    //   'session': value['session'],
    //   'fullname': _reg_fullname,
    //   'username': 'username_12',
    //   'bio': 'Hi there, this is my bio',
    //   'spikestatus_count': '0',
    //   'friends_count': '0',
    //   'photos': '',
    //   'relationshipStatus': '',
    //   'interests': '',
    //   'hideStatus': '',
    // }

    // new {relationship status, }
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getString('sessionGroupData') == null) {
      return 'empty';
    } else {
      return _prefs.getString('sessionGroupData');
    }
  }

  destroySession() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  updateSession(behavior, bvalue) async {
    // {
    //   'id': value['id'],
    //   'session': value['session'],
    //   'fullname': _reg_fullname,
    //   'username': 'username_12',
    //   'bio': 'Hi there, this is my bio',
    //   'status_count': '0',
    //   'friends_count': '0',
    //   'profilephoto': '',
    //   'relationshipStatus': '',
    //   'interests': '',
    //   'hideStatus': '',
    // }

    // new {relationship status, }
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getString('sessionGroupData') == null) {
      return 'empty';
    } else {
      //  this is where the magic begins
      //  this is where the magic begins

      // var userData = ;
      // var  = ;
      // print(json.decode(_prefs.getString('sessionGroupData')!));
      Map sessionData = json.decode(_prefs.getString('sessionGroupData')!);
      sessionData[behavior] = bvalue;

      String stringsessionData = json.encode(sessionData);
      _prefs.setString('sessionGroupData', stringsessionData);
      return 'complete';
    }
  }
}
