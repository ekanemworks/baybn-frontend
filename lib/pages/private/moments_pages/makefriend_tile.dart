import 'dart:convert';
import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class MakeFriendTile extends StatefulWidget {
  Map person;
  int userid;
  MakeFriendTile({Key? key, required this.person, required this.userid})
      : super(key: key);

  @override
  State<MakeFriendTile> createState() => MakeFriendTileState();
}

class MakeFriendTileState extends State<MakeFriendTile> {
  late Map _person = {};
  late int _userid;
  String display1 = 'true';
  bool _testString = true;
  String _matayas = '';
  final HttpService httpService = HttpService();

  @override
  void initState() {
    // TODO: implement initState
    _person = widget.person;
    _userid = widget.userid;
    // print(widget.person);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    String userid_p_variable = "p" + _userid.toString();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // padding: EdgeInsets.all(10),
                // color: Colors.blue,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/test2.png',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: InkWell(
                      onTap: () async {
                        _matayas = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewProfile(
                                    profileData: _person,
                                    userid: _userid,
                                    sourcePage: ''),
                              ),
                            ) ??
                            '';
                      },
                      child: Text(
                        _person["username"],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: _person["fullname"].length > 40
                        ? Text(
                            _person["bio"].toString().substring(0, 40) + '...',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )
                        : Text(
                            _person["fullname"].toString(),
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // checking if in friends with array
                json
                            .decode((_person["friends_with_array"]))
                            .indexOf(userid_p_variable) ==
                        -1
                    ? Container(
                        // checking if in friends request array
                        child: (json.decode(
                                        _person["friends_add_request_from"]))
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
                                            _person["friends_add_request_from"],
                                            _person["friends_with_array"],
                                          );

                                          // print(!_case1);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'Request sent',
                                              style: TextStyle(
                                                  color: Colors.indigo),
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
                                            _person["friends_add_request_from"],
                                            _person["friends_with_array"],
                                          );

                                          // print(!_case1);
                                        },
                                        child: Row(
                                          children: [
                                            Text('Pending',
                                                style: TextStyle(
                                                    color: Colors.indigo)),
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
                                    children: [
                                      Text('Unlink'),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
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
                                        padding: const EdgeInsets.all(4.0),
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
              ],
            ),
          ],
        ),
      ),
    );
    // return Center(child: const Text('ekanem'));
  }
}
