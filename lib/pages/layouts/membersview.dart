import 'package:baybn/pages/private/notification.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

import '../private/chats.dart';
import '../private/status.dart';
import '../private/me.dart';

import 'dart:convert';

class MembersView extends StatefulWidget {
  const MembersView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  String _session = '';
  String _fullname = '';
  String _username = '';
  String _bio = '';
  String _status_count = '';
  String _friends_count = '';
  String _profilephoto = '';
  String _relationshipStatus = '';
  String _stringTest = '';
  int _notification_count = 0;

  Brightness? _appmode = Brightness.dark;

  // Map userData = {};
  Map userData = {
    'id': 0,
    'session': '',
    'fullname': '',
    'username': '',
    'bio': '',
    'status_count': '',
    'friends_count': '',
    'profilephoto': '',
    'relationshipStatus': '',
    'interests': [],
    'hideStatus': '',
  };

  final SessionManagement sessionMgt = SessionManagement();
  final HttpService httpService = HttpService();
  String _matayas = '';
  @override
  void initState() {
    // use session management class to set session
    // use session management class to set session
    callSession();
    super.initState();
  }

  callSession() {
    // use session management class to set session
    // use session management class to set session
    sessionMgt.getSession().then(
          (value) => {
            setState(() {
              // decode
              userData = json.decode(value);
            }),
            checkNotification(userData['session'])
          },
        );
  }

  checkNotification(_session) {
    httpService.fetchNotificationCount(_session).then(
          (value) => {
            setState(() {
              if (value['status'] == 'ok') {
                _notification_count = value['body'];
              } else {
                _notification_count = 1;
              }
            }),
          },
        );
  }

  changeAppMode() {
    if (_appmode == Brightness.dark) {
      setState(() {
        _appmode = Brightness.light;
      });
    } else {
      setState(() {
        _appmode = Brightness.dark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: _appmode,
          accentColor: Colors.deepPurple),
      home: DefaultTabController(
        initialIndex: 2,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                      onPressed: () async {
                        _matayas = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notifications(
                                    userdata: userData, appmode: _appmode),
                              ),
                            ) ??
                            '';
                        if (_matayas == 'reload') {
                          checkNotification(userData['session']);
                        }
                      },
                    ),
                    _notification_count > 0
                        ? Positioned(
                            right: 11,
                            top: 11,
                            child: new Container(
                              padding: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                _notification_count.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
            bottom: const TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              tabs: [
                Tab(
                  text: 'CHATS',
                  icon: Icon(Icons.chat_bubble),
                ),
                Tab(
                  text: 'SPIKES',
                  icon: Icon(Icons.web_stories),
                ),
                Tab(
                  text: 'ME',
                  icon: Icon(Icons.person_rounded),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Chats(userdata: userData), // CHARTS PAGE
              Status(userdata: userData), // SPIKES PAGE
              Me(
                userdata: userData,
                appmode: _appmode,
                callback: (val) {
                  // Value can be sent back up from ME page widget
                  print(val);
                  if (val == 'reload') {
                    callSession();
                  } else if (val == 'changemode') {
                    changeAppMode();
                  }
                },
              ), // ME PAGE
            ],
          ),
        ),
      ),
    );
  }
}
