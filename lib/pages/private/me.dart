import 'dart:math';

import 'package:baybn/pages/private/me_pages/edit_interests.dart';
import 'package:baybn/pages/private/me_pages/editprofile.dart';
import 'package:baybn/pages/private/me_pages/milestones.dart';
import 'package:baybn/pages/private/me_pages/contacts.dart';
import 'package:baybn/pages/private/me_pages/settings.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class Me extends StatefulWidget {
  Map userdata;
  Brightness? appmode;
  final StringCallback callback;
  Me(
      {Key? key,
      required this.userdata,
      required this.appmode,
      required this.callback})
      : super(key: key);

  @override
  State<Me> createState() => MeState();
}

class MeState extends State<Me> {
  Map _userdata = {};
  String _matayas = '';
  final HttpService httpService = HttpService();

  @override
  void initState() {
    _userdata = widget.userdata;
    // print(_userdata);
    super.initState();
  }

  // didUpdate will Run when MembersView Layout widget gets the SESSION and updates UserDAta
  @override
  void didUpdateWidget(covariant Me oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _userdata = widget.userdata;
    });
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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        // color: Colors.purple,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // color: Colors.purple,
                  // child: Image.asset('assets/default.png'),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: _userdata['profilephoto'] == ''
                          ? Image.asset(
                              'assets/test2.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              httpService.serverAPI + _userdata['profilephoto'],
                              fit: BoxFit.cover,
                            )),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 13, 10, 7),
                  // color: Colors.purple,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: const Text('Edit Profile'),
                        // ),
                        ElevatedButton(
                          onPressed: () async {
                            _matayas = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfile(userdata: _userdata),
                                  ),
                                ) ??
                                '';
                            if (_matayas == 'reload') {
                              widget.callback('reload');
                              // print(_matayas);

                            }

                            print('_matayas');
                          },
                          child: const Text('Edit Profile'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            size: 30,
                          ),
                          onPressed: () async {
                            _matayas = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Settings(
                                        userdata: _userdata,
                                        appmode: widget.appmode),
                                  ),
                                ) ??
                                '';
                            print(_matayas);
                            if (_matayas == 'changemode') {
                              widget.callback('changemode');
                              // print(_matayas);

                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: 150,
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                      // color: Colors.purple,
                      // child: Image.asset('assets/default.png'),
                      child: Text(
                        _userdata['fullname'],
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      // width: 150,
                      margin: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                      // color: Colors.purple,
                      // child: Image.asset('assets/default.png'),
                      child: Text('@' + _userdata['username'],
                          style: TextStyle(fontSize: 17.0, color: Colors.grey)),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Text(_userdata['bio'],
                        style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            _userdata['status_count'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // Padding(padding: const EdgeInsets.all(2), chid:)
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              'Social',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Column(
                  //       children: [
                  //         Text(
                  //           _userdata['status_count'],
                  //           style: TextStyle(
                  //               fontSize: 20, fontWeight: FontWeight.bold),
                  //         ),
                  //         // Padding(padding: const EdgeInsets.all(2), chid:)
                  //         Padding(
                  //           padding: EdgeInsets.all(3.0),
                  //           child: Text(
                  //             'Status',
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
                            _userdata['friends_count'],
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
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
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
                    'Rap Sheet',
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
                        // onPressed: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const MyContacts(),
                        //     ),
                        //   );
                        // },

                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.people,
                              ),
                            ),
                            Text(
                              "My Contacts",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Contacts(userdata: _userdata),
                  ),
                );
              },
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
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.wine_bar,
                              ),
                            ),
                            Text(
                              'Social Life',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Milestones(),
                  ),
                );
              },
            ),
            // InkWell(
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(
            //           child: Container(
            //             // onPressed: () {
            //             //   Navigator.push(
            //             //     context,
            //             //     MaterialPageRoute(
            //             //       builder: (context) => const MyContacts(),
            //             //     ),
            //             //   );
            //             // },

            //             padding: EdgeInsets.all(10),
            //             child: Row(
            //               children: const [
            //                 Padding(
            //                   padding: EdgeInsets.all(10.0),
            //                   child: Icon(Icons.cases_outlined),
            //                 ),
            //                 Text(
            //                   'Bags',
            //                   style: TextStyle(
            //                     fontSize: 17,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.all(10.0),
            //           child: Icon(
            //             Icons.arrow_forward_ios,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Milestones(),
            //       ),
            //     );
            //   },
            // ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 19, 10, 7),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Spikes',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: SizedBox(
                  child: Stack(
                    children: [
                      DottedBorder(
                        color: Colors.pink,
                        strokeWidth: 4,
                        borderType: BorderType.Circle,
                        dashPattern: [((2 * pi * 30) / 2) - 10, 5],
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
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Icon(Icons.add, color: Colors.white, size: 15),
                          decoration: BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () async {
                        // Navigate back to first route when tapped.
                        _matayas = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditInterests(userdata: _userdata),
                              ),
                            ) ??
                            '';
                        if (_matayas == 'reload') {
                          widget.callback('reload');
                        }

                        // _userdata['interests']
                      },
                      child: const Text('Edit'),
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
                    _userdata['interests'].length > 0
                        ? Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 5,
                            runSpacing: 5,
                            children: _userdata['interests'].map<Widget>((i) {
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

            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 7),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'From Creft Technologies',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  column() {}
}
