import 'dart:convert';
import 'dart:math';
import 'package:baybn/pages/private/moment_open_text.dart';
import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MomentListTile extends StatefulWidget {
  Map person;
  int userid;
  String nowDate;
  MomentListTile(
      {Key? key,
      required this.person,
      required this.userid,
      required this.nowDate})
      : super(key: key);

  @override
  State<MomentListTile> createState() => MomentListTileState();
}

class MomentListTileState extends State<MomentListTile> {
  late Map _person = {};
  late int _userid;
  String display1 = 'true';
  bool _testString = true;
  String _matayas = '';
  List _my_activeMoments = [];
  String _nowDate = '';

  @override
  void initState() {
    // TODO: implement initState
    _person = widget.person;
    _userid = widget.userid;
    // _my_activeMoments = json.decode(_person['status_post_array']);
    if (_person['status_post_array'] == '' ||
        _person['status_post_array'] == "[]" ||
        _person['status_post_array'] == null) {
      // if moment/status column is empty:: DO NOTHING
    } else {
      // if moment/status column is empty:: DO NOTHING
      _my_activeMoments = json.decode(_person['status_post_array']);
    }
    _nowDate = widget.nowDate;
    // print(widget.person);
    super.initState();
  }

  void _openMoments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MomentOpenText(person: _person, userid: _userid, nowDate: _nowDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _openMoments();
      },
      child: Container(
        // color: Colors.green,
        margin: EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // padding: EdgeInsets.all(10),
                // color: Colors.blue,
                child: Center(
                  child: Container(
                    // width: 100,
                    // color: Colors.blue,
                    child: Stack(
                      children: [
                        _my_activeMoments.isEmpty
                            ? CircleAvatar(
                                radius: 34,
                                backgroundImage: AssetImage(
                                  'assets/test2.png',
                                ),
                              )
                            : DottedBorder(
                                color: Colors.yellow,
                                strokeWidth: 3,
                                borderType: BorderType.Circle,
                                dashPattern: [
                                  ((2 * pi * 30) / _my_activeMoments.length) -
                                      2,
                                  3
                                ],
                                child: CircleAvatar(
                                  radius: 34,
                                  backgroundImage: AssetImage(
                                    'assets/test2.png',
                                  ),
                                ),
                              ),
                        Positioned(
                          bottom: 0.0,
                          right: 1.0,
                          child: _my_activeMoments.isEmpty
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.add,
                                      color: Colors.white, size: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                // color: Colors.purple,
                height: 55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: Text(
                        _person["fullname"],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: _nowDate == _person["status_post_last_day"]
                          ? Text(
                              "today at " + _person["status_post_last_time"],
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            )
                          : Text(
                              "Yesterday at " +
                                  _person["status_post_last_time"],
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
