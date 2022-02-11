import 'package:baybn/pages/private/me_pages/settings_pages/change_password.dart';
import 'package:baybn/pages/private/me_pages/settings_pages/manage_privacy.dart';
import 'package:baybn/pages/private/me_pages/settings_pages/manage_recovery_email.dart';
import 'package:baybn/pages/public/launcher.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Map userdata;
  Brightness? appmode;
  Settings({Key? key, required this.userdata, required this.appmode})
      : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SessionManagement sessionMgt = SessionManagement();

  bool _value = true;

  @override
  void initState() {
    if (widget.appmode == Brightness.dark) {
      _value = true;
    } else {
      _value = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
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
                        'Security',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )),
                ),
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.password,
                                  ),
                                ),
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangePassword(userdata: widget.userdata),
                      ),
                    );
                  },
                ),
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.email,
                                  ),
                                ),
                                Text(
                                  'Manage Email',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ManageRecoveryEmail(userdata: widget.userdata),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 13, 10, 7),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'App mode',
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
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.mode_night,
                                ),
                              ),
                              Text(
                                'Change Mode',
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
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              this._value = value;
                            });
                            Navigator.of(context).pop('changemode');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.privacy_tip,
                                  ),
                                ),
                                Text(
                                  'Manage Privacy',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagePrivacy(),
                      ),
                    );
                  },
                ),
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.logout,
                                  ),
                                ),
                                Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    sessionMgt.destroySession();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LauncherPage(),
                      ),
                    );
                  },
                ),
              ],
            )));
  }
}
