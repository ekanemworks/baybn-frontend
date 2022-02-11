import 'dart:convert';
import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatefulWidget {
  Map notificationDatalist;
  int usersId;
  NotificationTile(
      {Key? key, required this.notificationDatalist, required this.usersId})
      : super(key: key);

  @override
  State<NotificationTile> createState() => NotificationTileState();
}

class NotificationTileState extends State<NotificationTile> {
  late Map _person = {};
  late int _userid;
  String display1 = 'true';
  bool _testString = true;
  bool _testString2 = true;
  final HttpService httpService = HttpService();

  var _matayas;

  @override
  void initState() {
    // TODO: implement initState
    _person = widget.notificationDatalist;
    _userid = widget.usersId;
    print('_userid');
    print(_userid);
    super.initState();
  }

  _makeFriendAction(userFromId, _userid, condition, friendsAddRequestTo,
      friendsWithArray, rejectedMyRequest) {
    // THE USERTOID, WHICH IS THE DESTINATION IS THE PERSON THAT IS VIEWING IT. TO ACCEPT OR REJECT
    var makeFriendActionObj = {
      'userFromId': userFromId,
      'userToId': _userid,
      'senderfriendsAddRequestTo': friendsAddRequestTo,
      'senderfriendsWithArray': friendsWithArray,
      'senderrejectedMyRequest': rejectedMyRequest
    };

    // EITHER ACCEPT OR REJECT
    // EITHER ACCEPT OR REJECT
    // EITHER ACCEPT OR REJECT
    if (condition == 'acceptAddRequest') {
      setState(() {
        _testString = !_testString;
      });
      httpService.acceptAddRequestAPIfunction(makeFriendActionObj).then(
            (value) => {
              if (value['status'] == 'ok')
                {print('okay')}
              else
                {
                  print('error'),
                  setState(() {
                    _testString = !_testString;
                  })
                }
            },
          );
    } else if (condition == 'rejectAddRequest') {
      setState(() {
        _testString2 = !_testString2;
      });
      httpService.rejectAddRequestAPIfunction(makeFriendActionObj).then(
            (value) => {
              if (value['status'] == 'ok')
                {print('okay')}
              else
                {
                  setState(() {
                    _testString2 = !_testString2;
                  })
                }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _testString2 == true
        ? Card(
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
                          margin:
                              EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          child: InkWell(
                            onTap: () async {
                              _matayas = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewProfile(
                                        profileData: _person,
                                        userid: _userid,
                                        sourcePage: 'notification',
                                      ),
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
                          margin:
                              EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          child: Text(
                            _person["fullname"].toString(),
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _testString == true
                          ?

                          // checking if button is clicked::: NO
                          // checking if button is clicked::: NO
                          ElevatedButton(
                              onPressed: () {
                                _makeFriendAction(
                                    _person["id"],
                                    _userid,
                                    'acceptAddRequest',
                                    _person["friends_add_request_to"],
                                    _person["friends_with_array"],
                                    _person["rejected_my_request"]);

                                // print(!_case1);
                              },
                              child: Row(
                                children: [
                                  Text('Confirm'),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: Icon(Icons.favorite),
                                  // )
                                ],
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          :

                          // checking if button is clicked::: YES
                          // checking if button is clicked::: YES
                          Container(
                              alignment: Alignment.centerRight,
                              // color: Colors.green,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Linked',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      _testString == true
                          ? InkWell(
                              onTap: () {
                                _makeFriendAction(
                                    _person["id"],
                                    _userid,
                                    'rejectAddRequest',
                                    _person["friends_add_request_to"],
                                    _person["friends_with_array"],
                                    _person["rejected_my_request"]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(Icons.close),
                              ),
                            )
                          : Container()
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
    // return Center(child: const Text('ekanem'));
  }
}
