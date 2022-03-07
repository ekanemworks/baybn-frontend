import 'dart:convert';

import 'package:baybn/pages/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ViewProfile extends StatefulWidget {
  Map profileData;
  int userid;
  String sourcePage;
  ViewProfile(
      {Key? key,
      required this.profileData,
      required this.userid,
      required this.sourcePage})
      : super(key: key);

  @override
  State<ViewProfile> createState() => ViewProfileState();
}

class ViewProfileState extends State<ViewProfile> {
  final HttpService httpService = HttpService();

  List<dynamic> _contacts = [];
  late String _username;
  late String _fullname;
  late String _profilephoto;
  late String _bio;
  late List _interests = [];
  late String _relationship_status;
  late String _university;
  late String _profession;
  late String _dateregistered;
  late Map _person = {};
  late int _userid;
  bool _testString = true;
  late String userid_p_variable;

  void initState() {
    _username = widget.profileData['username'];
    _fullname = widget.profileData['fullname'];
    _profilephoto = widget.profileData['profilephoto'];
    _bio = widget.profileData['bio'];
    _interests = json.decode(widget.profileData['interests']);
    _relationship_status = widget.profileData['relationship_status'];
    _university = widget.profileData['university'];
    _profession = widget.profileData['profession'];
    _dateregistered = widget.profileData['dateregistered'];
    _person = widget.profileData;
    _userid = widget.userid;
    userid_p_variable = "p" + _userid.toString();

    super.initState();
  }

  getContacts(_id) {
    httpService.fetchContactValues(_id).then(
          (value) => {
            setState(() {
              if (value['status'] == 'ok') {
                _contacts = value['body'];
                print(_contacts);
              } else if (value['status'] == 'error') {
                _showToast(context, value['message']);
              }
            })
          },
        );
  }

  _makeFriendAction(
      userToId, _userid, condition, friendsAddRequestFrom, friendsWithArray) {
    var makeFriendActionObj = {
      'userToId': userToId,
      'userFromId': _userid,
      'recieverfriendsAddRequestFrom': friendsAddRequestFrom,
      'recieverfriendsWithArray': friendsWithArray,
    };
    setState(() {
      _testString = !_testString;
    });
    if (condition == 'addfriendrequest') {
      httpService.sendAddRequestAPIfunction(makeFriendActionObj).then(
            (value) => {
              if (value['status'] == 'ok')
                {print('okay')}
              else
                {
                  setState(() {
                    _testString = !_testString;
                  })
                }
            },
          );
    } else if (condition == 'removefriendrequest') {
      httpService.removeAddRequestAPIfunction(makeFriendActionObj).then(
            (value) => {
              if (value['status'] == 'ok')
                {print('okay')}
              else
                {
                  setState(() {
                    _testString = !_testString;
                  })
                }
            },
          );
    } else {
      httpService.removeFriendAPIfunction(makeFriendActionObj).then(
            (value) => {
              if (value['status'] == 'ok')
                {print('okay')}
              else
                {
                  setState(() {
                    _testString = !_testString;
                  })
                }
            },
          );
    }
  }

  void handleClick(String value) {
    if (value == 'Report') {
      print('report');
    } else if (value == 'Block') {
      print('block');
    }
    // switch (value) {
    //   case 'Logout':
    //     break;
    //   case 'Settings':
    //     break;
    // }
  }

  void _share() {
    String message =
        "https://baybn.com/\nA fun social messaging app for everyone. Click the link to join me https://baybn.com/";
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message,
        subject: 'Description',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_username),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Stack(
              children: [
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Report', 'Block'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.more_vert,
                //     size: 30,
                //   ),
                //   onPressed: () async {},
                // ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                // color: Colors.purple,
                // child: Image.asset('assets/default.png'),
                child: ClipRRect(
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: 150,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                        // color: Colors.purple,
                        // child: Image.asset('assets/default.png'),
                        child: Text(
                          _fullname,
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // width: 150,
                        margin: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                        // color: Colors.purple,
                        // child: Image.asset('assets/default.png'),
                        child: Text('@' + _username,
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.grey)),
                      ),
                    ],
                  ),
                ],
              ),
              widget.sourcePage != 'notification'
                  ? Container(
                      width: 130,
                      child: json
                                  .decode((_person["friends_with_array"]))
                                  .indexOf(userid_p_variable) ==
                              -1
                          ? Container(
                              // checking if in friends request array
                              child: (json.decode(_person[
                                              "friends_add_request_from"]))
                                          .indexOf(userid_p_variable) ==
                                      -1
                                  ? Container(
                                      child: _testString == true
                                          ?

                                          // checking if button is clicked::: NO
                                          // checking if button is clicked::: NO
                                          ElevatedButton(
                                              onPressed: () {
                                                _makeFriendAction(
                                                  _person["id"],
                                                  _userid,
                                                  'addfriendrequest',
                                                  _person[
                                                      "friends_add_request_from"],
                                                  _person["friends_with_array"],
                                                );

                                                // print(!_case1);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('Add'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(Icons.favorite),
                                                  )
                                                ],
                                              ),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                            )
                                          :

                                          // checking if button is clicked::: YES
                                          // checking if button is clicked::: YES
                                          ElevatedButton(
                                              onPressed: () {
                                                _makeFriendAction(
                                                  _person["id"],
                                                  _userid,
                                                  'removefriendrequest',
                                                  _person[
                                                      "friends_add_request_from"],
                                                  _person["friends_with_array"],
                                                );

                                                // print(!_case1);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Request sent',
                                                    style: TextStyle(
                                                        color: Colors.indigo),
                                                  ),
                                                ],
                                              ),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                              ),
                                            ),
                                    )
                                  : Container(
                                      // checking if button is clicked::: NO
                                      // checking if button is clicked::: NO
                                      child: _testString == true
                                          ? ElevatedButton(
                                              onPressed: () {
                                                _makeFriendAction(
                                                  _person["id"],
                                                  _userid,
                                                  'removefriendrequest',
                                                  _person[
                                                      "friends_add_request_from"],
                                                  _person["friends_with_array"],
                                                );

                                                // print(!_case1);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('Pending',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.indigo)),
                                                ],
                                              ),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                              ),
                                            )
                                          :

                                          // checking if button is clicked::: YES
                                          // checking if button is clicked::: YES
                                          ElevatedButton(
                                              onPressed: () {
                                                _makeFriendAction(
                                                  _person["id"],
                                                  _userid,
                                                  'addfriendrequest',
                                                  _person[
                                                      "friends_add_request_from"],
                                                  _person["friends_with_array"],
                                                );

                                                // print(!_case1);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('Add'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(Icons.favorite),
                                                  )
                                                ],
                                              ),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                            )
                          :
                          // THEY ARE FRIENDS, INTENDS TO REMOVE FIRST OR LINK LATER
                          Container(
                              child: Container(
                                // checking if button is clicked::: NO
                                // checking if button is clicked::: NO
                                child: _testString == true
                                    ? ElevatedButton(
                                        onPressed: () {
                                          _makeFriendAction(
                                            _person["id"],
                                            _userid,
                                            'addfriendrequest',
                                            _person["friends_add_request_from"],
                                            _person["friends_with_array"],
                                          );

                                          // print(!_case1);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Unlink',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                      )
                                    :

                                    // checking if button is clicked::: YES
                                    // checking if button is clicked::: YES
                                    ElevatedButton(
                                        onPressed: () {
                                          _makeFriendAction(
                                            _person["id"],
                                            _userid,
                                            'addfriendrequest',
                                            _person["friends_add_request_from"],
                                            _person["friends_with_array"],
                                          );

                                          // print(!_case1);
                                        },
                                        child: Row(
                                          children: [
                                            Text('Add'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(Icons.favorite),
                                            )
                                          ],
                                        ),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                    )
                  : Container(),
              // checking if in friends with array

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      // color: Colors.green,
                      alignment: Alignment.center,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      child: Text(_bio,
                          style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    Text('Joined ' + _dateregistered),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           '0',
                    //           style: TextStyle(
                    //               fontSize: 20, fontWeight: FontWeight.bold),
                    //         ),
                    //         // Padding(padding: const EdgeInsets.all(2), chid:)
                    //         Padding(
                    //           padding: EdgeInsets.all(3.0),
                    //           child: Text(
                    //             'Social',
                    //             style:
                    //                 TextStyle(fontSize: 13, color: Colors.grey),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              json
                                  .decode(_person["friends_with_array"])
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Padding(padding: const EdgeInsets.all(2), chid:)
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'Friends',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            children: const [
                              Icon(
                                Icons.share,
                              ),
                              // Padding(padding: const EdgeInsets.all(2), chid:)
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  'Share',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            _share();
                          },
                        ),
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
                      'Profession',
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
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.cases_rounded,
                                ),
                              ),
                              Text(
                                _profession,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {},
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
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.school,
                                ),
                              ),
                              Text(
                                _university,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              ),

              // INTERESTS
              // INTERESTS
              // INTERESTS
              // INTERESTS
              Container(
                margin: const EdgeInsets.fromLTRB(10, 25, 10, 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Interests',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ExpansionTile(
              //   title: Text('Professional Life'),
              //   children: [Text('Ekanem'), Text('Tobe')],
              // ),
              Container(
                // color: Colors.grey.shade800,
                // margin: EdgeInsets.only(top: 20),
                // height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade700),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _interests.length > 0
                          ? Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 5,
                              runSpacing: 5,
                              children: _interests.map<Widget>((i) {
                                return Container(
                                  // margin: const EdgeInsets.only(left: 4),
                                  padding: EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.black54),
                                  child: Text(
                                    i,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            )
                          : Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text('0 Added'),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
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
