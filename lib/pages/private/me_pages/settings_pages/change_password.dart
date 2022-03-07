import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  Map userdata;
  ChangePassword({Key? key, required this.userdata}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  late String _session;
  late String _current_password;
  late String _new_password;

  @override
  void initState() {
    _session = widget.userdata['session'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Container(
          // color: Colors.deepPurple,
          // width: 100,
          // margin: const EdgeInsets.only(left: 40, right: 40),
          height: 200,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Current Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your current password';
                      }
                    },
                    onSaved: (value) {
                      _current_password = value!;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter new password';
                      }
                    },
                    onSaved: (value) {
                      _new_password = value!;
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
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      var ChangePasswordData = {
                        'currentpassword': _current_password,
                        'newpassword': _new_password,
                        'session': _session
                        // 'relationshipstatus': _reg_password,
                      };

                      // print(ChangePasswordData);

                      httpService
                          .changePasswordAPIfunction(ChangePasswordData)
                          .then((value) => {
                                if (value['status'] == 'ok')
                                  {_showToast(context, value['message'])}
                                else
                                  {_showToast(context, value['message'])}
                              });
                    },
                    child: const Text('Update password'),
                  ),
                ),

                const SizedBox(height: 20),

                // Text(mapdata.toString()),
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
  }
}
