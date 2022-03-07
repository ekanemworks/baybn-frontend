import 'package:baybn/pages/protected/setup.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage2 extends StatefulWidget {
  Map mapdataparameter;
  SignupPage2({Key? key, required this.mapdataparameter}) : super(key: key);

  @override
  _SignupPage2State createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  Map _mapdata = {};
  late String _reg_fullname;
  late String _reg_email;
  late String _reg_password;

  String myInitialGender = 'Gender';
  List myGender = ['Gender', '', 'Male', 'Female'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  @override
  void initState() {
    setState(() {
      _mapdata = widget.mapdataparameter;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.deepPurple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Step 2",
          style: TextStyle(
              fontSize: 19.0,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold
              // color: Colors.white,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          // color: Colors.deepPurple,
          // width: 100,
          margin: const EdgeInsets.only(left: 40, right: 40),
          height: 330,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Fullname to register';
                      }
                    },
                    onSaved: (value) {
                      _reg_fullname = value!;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email to register';
                      }

                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                    },
                    onSaved: (value) {
                      _reg_email = value!;
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 20),
                    // color: Colors.red,
                    child: DropdownButton(
                      value: myInitialGender,
                      isExpanded: true,
                      style: TextStyle(color: Colors.grey[700], fontSize: 17),
                      onChanged: (dynamic value) {
                        setState(() {
                          myInitialGender = value!;
                        });
                      },
                      items: myGender.map((items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Add a Security Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Security pin required';
                      }
                    },
                    onSaved: (value) {
                      _reg_password = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 180, // <-- Your width
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      // backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text(
                      'Create Account',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      var signupdata = {
                        'yearofbirth': _mapdata['yearofbirth'],
                        'country': _mapdata['country'],
                        'university': _mapdata['university'],
                        'fullname': _reg_fullname,
                        'email': _reg_email,
                        'gender': myInitialGender,
                        'password': _reg_password,
                      };

                      if (myInitialGender == 'Gender') {
                        _showToast(context, "Pick a gender");
                      } else {
                        httpService.signupAPIfunction(signupdata).then(
                              (value) async => {
                                if (value['status'] == 'ok')
                                  {
                                    if (value['message'] == 'signup successful')
                                      {
                                        // use session management class to set session
                                        // use session management class to set session
                                        sessionMgt.setSession({
                                          'id': value['body']['id'],
                                          'session': value['body']['session'],
                                          'fullname': _reg_fullname,
                                          'username': value['body']['username'],
                                          'bio': 'Hi there, this is my bio',
                                          'status_count': '0',
                                          'friends_count': '0',
                                          'profilephoto': '',
                                          'relationshipStatus': '',
                                          'interests': '',
                                          'hide_profile': '',
                                        }),

                                        // push to new page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Setup1(userdataparameter: {
                                              'session': value['body']
                                                  ['session'],
                                              'fullname': signupdata['fullname']
                                            }),
                                          ),
                                        )
                                      }
                                    else
                                      {_showToast(context, value['message'])}
                                  }
                                else
                                  {_showToast(context, value['message'])}
                              },
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
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
    // print(context);
  }
}
