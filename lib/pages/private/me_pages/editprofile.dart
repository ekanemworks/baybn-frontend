import 'package:baybn/pages/private/me_pages/edit_profilephoto.dart';
import 'package:flutter/material.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  Map userdata;
  EditProfile({Key? key, required this.userdata}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  String myInitialItem = '<Relationship Status>';
  String _reload_check = '';
  late int _userid;
  late String _edit_fullname;
  late String _edit_username;
  late String _edit_bio;
  late String _session;
  late String _edit_profilephoto;
  late String _status_count;
  late String _friends_count;
  late List _interests;
  late String _profilephoto = '';
  late String _relationshipStatus;
  late String _hideStatus;

  final List myItems = [
    '<Relationship Status>',
    'Single',
    'Dating',
    'Married',
    'Entanglement',
    'I rather not say!',
  ]; // List of items to show in dropdownlist

  @override
  void initState() {
    _userid = widget.userdata['id'];
    _edit_fullname = widget.userdata['fullname'];
    _edit_username = widget.userdata['username'];
    _edit_bio = widget.userdata['bio'];
    _session = widget.userdata['session'];
    _edit_profilephoto = widget.userdata['profilephoto'];
    _friends_count = widget.userdata['friends_count'];
    _status_count = widget.userdata['status_count'];
    _interests = widget.userdata['interests'];
    _hideStatus = widget.userdata['hide_profile'];
    if (widget.userdata['relationshipStatus'] == '' ||
        widget.userdata['relationshipStatus'] == null) {
    } else {
      myInitialItem = widget.userdata['relationshipStatus'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop('reload'),
        ),
        title: const Text("Edit Profile"),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();

                var editProfiledata = {
                  'fullname': _edit_fullname,
                  'username': _edit_username,
                  'bio': _edit_bio,
                  'session': _session,
                  'relationshipStatus': myInitialItem
                  // 'relationshipstatus': _reg_password,
                };

                print(editProfiledata);

                httpService
                    .editprofileAPIfunction(editProfiledata)
                    .then((value) async => {
                          if (value['status'] == 'ok')
                            {
                              if (value['message'] == 'success')
                                {
                                  // use session management class to set session
                                  // use session management class to set session

                                  sessionMgt.setSession({
                                    'id': _userid,
                                    'session': _session,
                                    'fullname': _edit_fullname,
                                    'username': _edit_username,
                                    'bio': _edit_bio,
                                    'status_count': _status_count,
                                    'friends_count': _friends_count,
                                    'profilephoto': _edit_profilephoto,
                                    'relationshipStatus': myInitialItem,
                                    'interests': _interests,
                                    'hide_profile': _hideStatus
                                  }),
                                  _showToast(context, 'Changes Saved')
                                }
                              else
                                {_showToast(context, value['message'])}
                            }
                          else
                            {_showToast(context, value['message'])}
                        });
                // print(signupdata);
              },
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        // color: Colors.purple,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // color: Colors.purple,
                    // child: Image.asset('assets/default.png'),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: _edit_profilephoto == ''
                          ? Image.asset(
                              'assets/test2.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              httpService.serverAPI + _edit_profilephoto,
                              fit: BoxFit.cover,
                            ),
                    )),
                SizedBox(
                  // width: 100, // <-- Your width
                  // height: 50, // <-- Your height
                  child: ElevatedButton(
                    onPressed: () async {
                      _reload_check = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilephoto(),
                            ),
                          ) ??
                          '';
                      // if (_reload_check == 'reload') {
                      //   widget.callback('reload');
                      //   // print(_matayas);
                      // }
                      setState(() {
                        _edit_profilephoto = _reload_check;
                      });

                      print('_matayas');
                    },
                    child: const Text('Change'),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey)),
                  ),
                ),
              ],
            ),
            Container(
              // color: Colors.deepPurple,
              // width: 100,
              // margin: const EdgeInsets.only(left: 40, right: 40),
              height: 400,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _edit_fullname,
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Full name cannot be empty';
                          }
                        },
                        onSaved: (value) {
                          _edit_fullname = value!;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: _edit_username,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'username cannot be empty';
                          }
                        },
                        onSaved: (value) {
                          _edit_username = value!;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: _edit_bio,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 3,
                        maxLines: 3,
                        maxLength: 100,
                        decoration: const InputDecoration(
                            labelText: 'Bio (limit 100 characters)'),
                        onSaved: (value) {
                          _edit_bio = value!;
                        },
                      ),
                    ),

                    DropdownButton(
                      value: myInitialItem,
                      isExpanded: true,
                      onChanged: (dynamic value) {
                        setState(() {
                          myInitialItem = value!;
                        });
                      },
                      items: myItems.map((items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Text(mapdata.toString()),
                  ],
                ),
              ),
            )
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

  // void setState(Null Function() param0) {}
}
