import 'package:baybn/pages/layouts/membersview.dart';
import 'package:baybn/pages/public/forgot_password.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({Key? key}) : super(key: key);

  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  String stringResponse = '1';

  late String _emailorphone;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  @override
  void initState() {
    // print(listResponse);

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
          "Login",
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
          margin: const EdgeInsets.only(left: 40, right: 40),
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email '),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email address';
                    }

                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  },
                  onSaved: (value) {
                    _emailorphone = value!;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Security password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();

                    // print(_age);
                    // print(myInitialItem);

                    var loginmapdata = {
                      'emailorphone': _emailorphone,
                      'password': _password,
                    };

                    print(loginmapdata);

                    httpService
                        .loginAPIfunction(loginmapdata)
                        .then((value) async => {
                              if (value['status'] == 'ok')
                                {
                                  // use session management class to set session
                                  // use session management class to set session

                                  sessionMgt.setSession({
                                    'id': value['body']['id'],
                                    'session': value['body']['session'],
                                    'fullname': value['body']['fullname'],
                                    'username': value['body']['username'],
                                    'bio': value['body']['bio'],
                                    'status_count': '0',
                                    'friends_count': json
                                        .decode(
                                            value['body']['friends_with_array'])
                                        .length
                                        .toString(),
                                    'profilephoto': value['body']
                                        ['profilephoto'],
                                    'relationshipStatus': '',
                                    'interests':
                                        json.decode(value['body']['interests']),
                                    'hide_profile': value['body']
                                        ['hide_profile'],
                                  }),

                                  // push to new page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MembersView(
                                        title: 'Baybn',
                                      ),
                                    ),
                                  )
                                }
                              else
                                {_showToast(context, value['message'])}
                            });
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 25),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword1(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                )
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
    print(context);
  }
}
