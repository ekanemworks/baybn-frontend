import 'dart:convert';
import 'dart:math';

import 'package:baybn/pages/private/status_pages/FilterDiscoverMember.dart';
import 'package:baybn/pages/private/status_pages/createstatus_text.dart';
import 'package:baybn/pages/private/status_pages/discover.dart';
import 'package:baybn/pages/private/status_pages/makefriend_tile.dart';
import 'package:baybn/pages/private/status_pages/makefriends.dart';
import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:baybn/pages/widgets/app_large_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MakeFriends extends StatefulWidget {
  MakeFriends({Key? key}) : super(key: key);

  @override
  State<MakeFriends> createState() => MakeFriendsState();
}

class MakeFriendsState extends State<MakeFriends> {
  List<dynamic> _active_chats = [
    {"displaypicture": "s", "fullname": "Michael", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Mom2", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Josh", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Geepee", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Mom2", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Josh", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Geepee", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Josh", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Geepee", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Mom2", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Josh", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Geepee", "lastchat": "s"},
  ];
  final HttpService httpService = HttpService();
  late String _session = "";
  bool popularContainerShow = true;
  bool popularContainerShowValuesCheck = true;
  late int _userid = 0;
  late Map _userdata;
  List<dynamic> _baybn_members_popular = [];
  List<dynamic> _baybn_members_general = [];
  final SessionManagement sessionMgt = SessionManagement();
  String _matayas = '';

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
              // decode

              _userdata = json.decode(value);
              _userid = _userdata['id'];
              // print(_userdata['id']);
              _session = _userdata['session'];
              // print(_session);

              _fetchMembersPopular();
              _fetchMembersGeneral();
            })
          },
        );
  }

  void _fetchMembersPopular() {
    httpService.fetchActiveMembersPopular({"session": _session}).then(
      (value) => {
        setState(() {
          _baybn_members_popular = value['body'];
          if (_baybn_members_popular.isEmpty) {
            popularContainerShowValuesCheck = false;
          }
          // print(interestAvailable);
        })
      },
    );
  }

  void _fetchMembersGeneral() {
    httpService.fetchActiveMembersGeneral({"session": _session}).then(
      (value) => {
        setState(() {
          _baybn_members_general = value['body'];
          // print(interestAvailable);
        })
      },
    );
  }

  _onStartScroll(ScrollMetrics metrics) {
    // print("Scroll Start");
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    if (metrics.extentAfter == 482.0) {
      // print('object');
      setState(() {
        popularContainerShow = true;
      });
    } else {
      setState(() {
        popularContainerShow = false;
      });
    }
  }

  _onEndScroll(ScrollMetrics metrics) {
    // print("Scroll End");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Discover people')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            _onStartScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            _onEndScroll(scrollNotification.metrics);
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            // scrollDirection: Axis.horizontal,
            children: [
              popularContainerShowValuesCheck == true
                  ? Container(
                      child: popularContainerShow == true
                          ? Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: const Text(
                                            'Popular',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          margin: const EdgeInsets.all(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // scrollDirection: Axis.horizontal,
                                    children: _baybn_members_popular.map((e) {
                                      // return listItem(_baybn_members.indexOf(e));
                                      return MakeFriendTile(
                                          person: e, userid: _userid);
                                    }).toList(),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    )
                  : Container(),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Club Members',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterDiscoverMember(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(128, 128, 128, 1)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.sort,
                                    color: Colors.deepPurple,
                                  ),
                                )
                              ],
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // backgroundColor: MaterialStateProperty.all(
                              //   Color.fromRGBO(0, 0, 0, 1),
                              // ),
                            ),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, top: 20, right: 10),
                    ),
                  ),
                ],
              )),
              Container(
                // color: Colors.green,
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height - 120,
                // height: 1000,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3),
                  children: _baybn_members_general.map((e) {
                    return listItem2(e);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem2(_value) {
    var firstname = _value['fullname'].split(" ");
    if (firstname.isNotEmpty) {
      firstname = firstname[0];
    }
    return InkWell(
      onTap: () async {
        _matayas = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewProfile(
                    profileData: _value, userid: _userid, sourcePage: ''),
              ),
            ) ??
            '';
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: _value['profilephoto'] == ''
                ? DecorationImage(
                    image: AssetImage("assets/test2.png"),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage(
                        httpService.serverAPI + _value['profilephoto']),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromRGBO(0, 0, 0, 0.2),
              ),
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width - 10,
                      // color: Colors.green,
                      child: Text(
                        firstname,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 10,
                      child: Text(
                        '@' + _value['username'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width - 10,
                      child: Text(
                        _value['bio'],
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )

              // Stack(
              //   children: [
              //     Align(
              //       alignment: Alignment.bottomCenter,
              //       child: Container(
              //         child: Text('Ekanem'),
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 11,
              //       child: Container(
              //         padding: EdgeInsets.all(2),
              //         decoration: BoxDecoration(
              //             // color: Colors.red,
              //             // borderRadius: BorderRadius.circular(6),
              //             ),
              //         constraints: BoxConstraints(
              //           minWidth: 14,
              //           minHeight: 14,
              //         ),
              //         child: Column(
              //           children: [
              //             Text(
              //               firstname,
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold),
              //               textAlign: TextAlign.center,
              //             ),
              //             Text(
              //               _value['username'],
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 11,
              //                   fontWeight: FontWeight.bold),
              //               textAlign: TextAlign.center,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              ),
        ),
      ),
    );
  }
}
