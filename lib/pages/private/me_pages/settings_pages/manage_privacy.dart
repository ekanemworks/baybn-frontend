import 'dart:convert';

import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class ManagePrivacy extends StatefulWidget {
  ManagePrivacy({Key? key}) : super(key: key);

  @override
  _ManagePrivacyState createState() => _ManagePrivacyState();
}

class _ManagePrivacyState extends State<ManagePrivacy> {
  final SessionManagement sessionMgt = SessionManagement();
  final HttpService httpService = HttpService();

  bool _profileVisibility = false;
  Map _userdata = {};

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
            // print(json.decode(value)['hide_profile']),
            if (json.decode(value)['hide_profile'] == 'off' ||
                json.decode(value)['hide_profile'] == '' ||
                json.decode(value)['hide_profile'] == false)
              {
                setState(() {
                  // decode
                  _profileVisibility = false;
                  _userdata = json.decode(value);
                }),
              }
            else
              {
                setState(() {
                  // decode
                  _profileVisibility = true;
                  _userdata = json.decode(value);
                }),
              }
          },
        );
  }

  changeHideStatus() {
    var profileVisibilityStatusMap = {
      'hide_profile': _profileVisibility,
      'session': _userdata['session'],
    };
    httpService.changeHideStatusAPIfunction(profileVisibilityStatusMap).then(
          (value) async => {
            if (value['status'] == 'ok')
              {
                sessionMgt.updateSession('hide_profile', _profileVisibility),
                _showToast(context, value['message'])
              }
            else
              {
                _showToast(context, value['message']),
              }
          },
        );
    // 1.)  Change on Server,
    // 2.) Update Session management
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 13, 20, 7),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 13, 10, 7),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Privacy',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  )),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                      child: Row(
                        children: const [
                          Text(
                            'Hide profile on discover',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Switch.adaptive(
                      value: _profileVisibility,
                      onChanged: (value) {
                        setState(() {
                          this._profileVisibility = value;
                        });
                        changeHideStatus();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
