import 'dart:convert';

import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/moment_post_management.dart';
import 'package:flutter/material.dart';

class CreateStatusText extends StatefulWidget {
  Map userdata;
  CreateStatusText({Key? key, required this.userdata}) : super(key: key);

  @override
  State<CreateStatusText> createState() => CreateStatusTextState();
}

class CreateStatusTextState extends State<CreateStatusText> {
  final HttpService httpService = HttpService();
  final MomentsPostManagement momentsPostManagement = MomentsPostManagement();
  String _statusText = '';
  List themeColors = [
    Colors.blue.shade200,
    Colors.blue.shade400,
    Colors.blue.shade600,
    Colors.blue.shade900,
    Colors.green.shade200,
    Colors.green.shade400,
    Colors.green.shade600,
    Colors.green.shade900,
    Colors.indigo.shade200,
    Colors.indigo.shade400,
    Colors.indigo.shade600,
    Colors.indigo.shade900,
    Colors.yellow.shade200,
    Colors.yellow.shade400,
    Colors.yellow.shade600,
    Colors.orange.shade200,
    Colors.orange.shade400,
    Colors.orange.shade600,
    Colors.pink.shade200,
    Colors.pink.shade400,
    Colors.pink.shade600,
    Colors.red.shade200,
    Colors.red.shade400,
    Colors.red.shade600,
    Colors.purple.shade400,
    Colors.purple.shade600,
    Colors.brown.shade400,
    Colors.brown.shade600,
    Colors.grey.shade400,
    Colors.grey.shade600,
    Colors.teal.shade200,
    Colors.teal.shade600
  ];
  late Color _choosenThemeColor;
  late int _choosenThemeIndex;

  bool _displaySendbtn = false;

  changeThemeColor(index) {
    if ((themeColors.length - 1) == index) {
      // has reached end of list
      setState(() {
        _choosenThemeColor = themeColors[0];
        _choosenThemeIndex = 0;
      });
    } else {
      if (_choosenThemeColor == themeColors[index]) {
        index++;
        setState(() {
          _choosenThemeColor = themeColors[index];
          _choosenThemeIndex = index;
        });
      }
    }
  }

  // FUNCTION TO UPLOAD STATUS TO BACKEND
  // FUNCTION TO UPLOAD STATUS TO BACKEND
  void sendStatus(_statusValues) {
    // sending new status post to status management before database upload
    // sending new status post to status management before database upload
    httpService.sendStatusTextAPIfunction(_statusValues).then((value) async => {
          if (value['status'] == 'ok')
            {
              // use session management class to set session
              // use session management class to set session

              momentsPostManagement.addMomentsPost(_statusValues),
              Navigator.of(context).pop('reload')
            }
          else
            {_showToast(context, value['message'])}
        });
  }

  @override
  void initState() {
    _choosenThemeColor = themeColors[0];
    _choosenThemeIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _choosenThemeColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent, // 1
          elevation: 0),
      body: Container(
        child: Stack(
          children: [
            Center(
              child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                textAlign: TextAlign.center,
                minLines: 1,
                maxLines: 15,
                maxLength: 700,
                onChanged: (value) {
                  _statusText = value;
                  if (value.length > 0) {
                    setState(() {
                      _displaySendbtn = true;
                    });
                  } else {
                    setState(() {
                      _displaySendbtn = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type a status",
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
                onSaved: (value) {
                  _statusText = value!;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: IconButton(
                              icon: const Icon(Icons.emoji_emotions_outlined,
                                  size: 35),
                              onPressed: () {
                                // socketConnect();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: IconButton(
                              icon: const Icon(Icons.font_download, size: 35),
                              onPressed: () {
                                // socketConnect();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: IconButton(
                              icon: const Icon(Icons.color_lens, size: 35),
                              onPressed: () {
                                // socketConnect();
                                changeThemeColor(_choosenThemeIndex);
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.only(bottom: 8, right: 2, left: 2),
                        child: _displaySendbtn == true
                            ? CircleAvatar(
                                radius: 25,
                                child: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    var _statusValues = {
                                      "type": 'text',
                                      "text": _statusText,
                                      "colorTheme":
                                          _choosenThemeColor.toString(),
                                      "session": widget.userdata['session'],
                                      "views": 0
                                    };
                                    sendStatus(_statusValues);
                                  },
                                ),
                              )
                            : SizedBox(),
                      )
                    ],
                  )),
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
}
