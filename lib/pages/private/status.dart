import 'dart:math';

import 'package:baybn/pages/private/status_pages/createstatus_text.dart';
import 'package:baybn/pages/private/status_pages/discover.dart';
import 'package:baybn/pages/private/status_pages/makefriends.dart';
import 'package:baybn/pages/widgets/app_large_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  Map userdata;
  Status({Key? key, required this.userdata}) : super(key: key);

  @override
  State<Status> createState() => StatusState();
}

class StatusState extends State<Status> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // scrollDirection: Axis.horizontal,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    child: const Text(
                      'My Spikes',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    margin: const EdgeInsets.all(10),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MakeFriends(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Discover',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.people,
                          ),
                        )
                      ],
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                ),
              ],
            ),
            // Container(
            //   color: Colors.green,
            //   width: MediaQuery.of(context).size.width - 10,
            //   height: 120,
            //   child: ListView(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     children: _active_chats.map((e) {
            //       return listItem(_active_chats.indexOf(e));
            //     }).toList(),
            //   ),
            // ),
            Container(
              // color: Colors.green,
              // height: 120,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    child: const Text(
                      'Friends Update',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    margin: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
            Column(
              // scrollDirection: Axis.horizontal,
              children: _active_chats.map((e) {
                return listItem(_active_chats.indexOf(e));
              }).toList(),
            )
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CreateStatusText(userdata: widget.userdata),
              ),
            );
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

    // Center(
    //   child: ListView(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Expanded(
    //             child: Container(
    //               child: const Text(
    //                 'Trending',
    //                 style: TextStyle(fontSize: 20.0),
    //               ),
    //               margin: const EdgeInsets.all(10),
    //             ),
    //           ),
    //           Container(
    //             child: ElevatedButton(
    //               onPressed: () {},
    //               child: const Text('Make Friends'),
    //               style: ButtonStyle(
    //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                   RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4.0),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             margin: const EdgeInsets.all(10),
    //           ),
    //         ],
    //       ),
    //       Container(
    //         // width: double.maxFinite, // maximum width
    //         // height: double.maxFinite,
    //         child: Expanded(
    //           child: ListView(
    //             // scrollDirection: Axis.horizontal,
    //             children: _active_chats.map((e) {
    //               return listItem(_active_chats.indexOf(e));
    //             }).toList(),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // width: double.maxFinite, // maximum width
    //         // height: double.maxFinite,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 child: const Text(
    //                   'Trending',
    //                   style: TextStyle(fontSize: 20.0),
    //                 ),
    //                 margin: const EdgeInsets.all(10),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         // width: double.maxFinite, // maximum width
    //         // height: double.maxFinite,
    //         child: Expanded(
    //           child: ListView(
    //             // scrollDirection: Axis.horizontal,
    //             children: _active_chats.map((e) {
    //               return listItem(_active_chats.indexOf(e));
    //             }).toList(),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // width: double.maxFinite, // maximum width
    //         // height: double.maxFinite,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 child: const Text(
    //                   'Trending',
    //                   style: TextStyle(fontSize: 20.0),
    //                 ),
    //                 margin: const EdgeInsets.all(10),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         // width: double.maxFinite, // maximum width
    //         // height: double.maxFinite,
    //         child: Expanded(
    //           child: ListView(
    //             // scrollDirection: Axis.horizontal,
    //             children: _active_chats.map((e) {
    //               return listItem(_active_chats.indexOf(e));
    //             }).toList(),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget listItem(int index) {
    return Column(children: [
      InkWell(
        onTap: () async {},
        child: Container(
          height: 100,
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_active_chats[index]["fullname"]),
          ),
        ),
      ),
    ]);
  }
}
