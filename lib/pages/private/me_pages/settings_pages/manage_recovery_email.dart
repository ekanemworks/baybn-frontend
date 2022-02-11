import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class ManageRecoveryEmail extends StatefulWidget {
  Map userdata;
  ManageRecoveryEmail({Key? key, required this.userdata}) : super(key: key);

  @override
  _ManageRecoveryEmailState createState() => _ManageRecoveryEmailState();
}

class _ManageRecoveryEmailState extends State<ManageRecoveryEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  late String _session;
  late String _newRecoveryEmail;

  @override
  void initState() {
    _session = widget.userdata['session'];
    super.initState();
  }

  sendVerificationCode(sendVerificationToMap) {
    httpService.sendVerificationCodeToEmail(sendVerificationToMap).then(
          (value) => {
            setState(() {
              if (value['status'] == 'ok') {
              } else {}
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recovery Email"),
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
                  child: Row(
                    children: [
                      Text('Recovery email:', style: TextStyle(fontSize: 20)),
                      Text('none'),
                      Text('<not verified>'),
                    ],
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter new Email';
                      }
                    },
                    onSaved: (value) {
                      _newRecoveryEmail = value!;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();

                    var sendVerificationToMap = {
                      'email': _newRecoveryEmail,
                      'session': _session
                      // 'relationshipstatus': _reg_password,
                    };

                    sendVerificationCode(sendVerificationToMap);
                  },
                  child: const Text('Verify Email'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
