import 'package:baybn/pages/layouts/membersview.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class SetupProfilephoto extends StatefulWidget {
  SetupProfilephoto({Key? key}) : super(key: key);

  @override
  _SetupProfilephotoState createState() => _SetupProfilephotoState();
}

class _SetupProfilephotoState extends State<SetupProfilephoto> {
  Map userData = {
    'session': '',
    'fullname': '',
    'username': '',
    'bio': '',
    'status_count': '',
    'friends_count': '',
    'profilephoto': '',
    'relationshipStatus': '',
    'interests': [],
  };
  late String _profilephoto = '';
  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();
  File? _image;
  String base64Image = '';

  @override
  void initState() {
    callSession();

    super.initState();
  }

  callSession() {
    // use session management class to set session
    // use session management class to set session
    sessionMgt.getSession().then(
          (value) => {
            setState(() {
              print('Setup Profilephoto get session to check photo');
              // decode
              userData = json.decode(value);
              _profilephoto = userData['profilephoto'];
            })
          },
        );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        _image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  uploadFromPage() {
    http
        .post(Uri.parse(httpService.serverAPI + 'updateProfilePhoto'),
            headers: {"Content-Type": "application/json"},
            body: json
                .encode({"image": base64Image, "session": userData['session']}))
        .then((value) {
      var mainResponse = json.decode(value.body);

      if (value.statusCode == 200) {
        if (mainResponse['status'] == 'ok') {
          sessionMgt.updateSession(
              'profilephoto', mainResponse['body']['imagePathOnDB']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MembersView(
                title: 'Baybn',
              ),
            ),
          );
        } else {
          _showToast(context, mainResponse['message']);
        }
      } else {
        print('error');
        _showToast(context, mainResponse['message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Display Photo",
          style: TextStyle(
              fontSize: 19.0,
              // color: Colors.deepPurple,
              fontWeight: FontWeight.bold
              // color: Colors.white,
              ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
            child: _image == null
                ? OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MembersView(
                            title: 'Baybn',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {
                      base64Image = base64Encode(_image!.readAsBytesSync());
                      uploadFromPage();
                    },
                    child: const Text(
                      'Upload',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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

                  child: _image == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: _profilephoto == ''
                              ? Image.asset(
                                  'assets/test2.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  httpService.serverAPI + _profilephoto,
                                  fit: BoxFit.cover,
                                ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                SizedBox(
                  // width: 100, // <-- Your width
                  // height: 50, // <-- Your height
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text('Change Photo'),
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
