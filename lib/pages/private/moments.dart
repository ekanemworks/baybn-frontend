import 'dart:convert';
import 'dart:math';

import 'package:baybn/pages/private/moments_list_tile.dart';
import 'package:baybn/pages/private/moments_pages/createstatus_text.dart';
import 'package:baybn/pages/private/moments_pages/discover.dart';
import 'package:baybn/pages/private/moments_pages/makefriends.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/moment_post_management.dart';
import 'package:baybn/pages/widgets/app_large_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Moments extends StatefulWidget {
  Map userdata;
  Moments({Key? key, required this.userdata}) : super(key: key);

  @override
  State<Moments> createState() => MomentsState();
}

class MomentsState extends State<Moments> {
  Map _userdata = {};
  int _userid = 0;
  final HttpService httpService = HttpService();
  final MomentsPostManagement momentsPostManagement = MomentsPostManagement();
  List _my_activeMoments = [];
  List _friends_activeMoments = [];
  String _matayas = '';
  String _nowDate = '';

  @override
  void initState() {
    _userdata = widget.userdata;
    _userid = widget.userdata['id'];
    call_MyMoments();
    call_Friends_Moments(widget.userdata['id']);
    // print(_userdata);
    super.initState();
  }

  // didUpdate will Run when MembersView Layout widget gets the SESSION and updates UserDAta
  @override
  void didUpdateWidget(covariant Moments oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _userdata = widget.userdata;
    });
  }

  call_MyMoments() {
    // use session management class to set session
    // use session management class to set session
    momentsPostManagement.getMomentsPost().then(
          (value) => {
            // print(value),
            if (value == 'empty')
              {}
            else
              {
                setState(() {
                  // decode
                  _my_activeMoments = json.decode(value);
                }),
              },
            // print(_my_activeMoments.length)
          },
        );
  }

  call_Friends_Moments(_id) {
    httpService.fetchFriendsMomentsValues(_id).then(
          (value) => {
            setState(() {
              if (value['status'] == 'ok') {
                _friends_activeMoments = value['body'];
                _nowDate = value['nowDate'];
                // print(_friends_activeMoments);
              } else if (value['status'] == 'error') {
                _showToast(context, value['message']);
              }
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // scrollDirection: Axis.horizontal,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MakeFriends(),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: _userdata['profilephoto'] == ''
                                ? DecorationImage(
                                    image: AssetImage("assets/test2.png"),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(httpService.serverAPI +
                                        _userdata['profilephoto']),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: Container(
                                // width: 100,
                                // color: Colors.blue,
                                child: Stack(
                                  children: [
                                    _my_activeMoments.isEmpty
                                        ? CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(
                                              'assets/test2.png',
                                            ),
                                          )
                                        : DottedBorder(
                                            color: Colors.yellow,
                                            strokeWidth: 4,
                                            borderType: BorderType.Circle,
                                            dashPattern: [
                                              ((2 * pi * 30) /
                                                      _my_activeMoments
                                                          .length) -
                                                  2,
                                              3
                                            ],
                                            child: CircleAvatar(
                                              radius: 30,
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
                                                  color: Colors.white,
                                                  size: 15),
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
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MakeFriends(),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("assets/test2.png"),
                                fit: BoxFit.cover,
                              )),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Club Members',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.people,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // BELOW MY MOMENTS
            // BELOW MY MOMENTS
            // BELOW MY MOMENTS

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    child: const Text(
                      'Updates',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    margin: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
            Column(
              // scrollDirection: Axis.horizontal,
              children: _friends_activeMoments.map((e) {
                return MomentListTile(
                    person: e, userid: _userid, nowDate: _nowDate);
              }).toList(),
            )
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () async {
            _matayas = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateStatusText(userdata: widget.userdata),
                  ),
                ) ??
                '';
            if (_matayas == 'reload') {
              call_MyMoments();
              // print(_matayas);

            }
          },
          heroTag: null,
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () {},
          heroTag: null,
        )
      ]),
    );
  }

  // Widget listItem(int index) {
  //   return Column(children: [
  //     InkWell(
  //       onTap: () async {},
  //       child: Container(
  //         color: Colors.green,
  //         height: 90,
  //         padding: EdgeInsets.only(left: 16),
  //         margin: EdgeInsets.all(4),
  //         child:
  //         Row(
  //           children: [

  //           ],
  //           )

  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text(_friends_activeMoments[index]["fullname"]),
  //         ),
  //       ),
  //     ),
  //   ]);
  // }

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
