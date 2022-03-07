import 'dart:convert';

import 'package:baybn/pages/private/chats_pages/chart_page.dart';
import 'package:baybn/pages/services/chats_management.dart';
import 'package:flutter/material.dart';

import 'chats_pages/start_new_chat_contact_list.dart';

class Chats extends StatefulWidget {
  Map userdata;
  Chats({Key? key, required this.userdata}) : super(key: key);

  @override
  State<Chats> createState() => ChatsState();
}

class ChatsState extends State<Chats> {
  final ChatsManagement chatsManagement = ChatsManagement();
  List<dynamic> _chats_list = [];
  List<dynamic> _active_chats = [
    {"displaypicture": "s", "fullname": "Michael", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Mom2", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Josh", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Geepee", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Mfon Bassey", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Moyo", "lastchat": "s"},
    {"displaypicture": "s", "fullname": "Jessica", "lastchat": "s"},
  ];

  String _chat_activity = '';

  void initState() {
    call_Chats();
    setState(() {});
    // print(_active_chats);
    super.initState();
  }

  call_Chats() {
    // use session management class to set session
    // use session management class to set session
    chatsManagement.getChats().then(
          (value) => {
            // print(value),
            if (value == 'empty')
              {}
            else
              {
                setState(() {
                  // decode
                  _chats_list = json.decode(value);
                }),
              },
            // print(_my_activeMoments.length)
          },
        );
  }

  reArrangeList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _chats_list.isEmpty
          ? Center(
              child: Container(
                height: 300,
                // color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      decoration: const BoxDecoration(
                        // in container if you want to show a background image you need box decoration
                        image: DecorationImage(
                            image: AssetImage("assets/chatsimg.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: const Text(
                        'new chats will appear here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: _chats_list.map((e) {
                  return listItem(_chats_list.indexOf(e));
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StartNewChat(
                  userdata: widget.userdata,
                ),
              ),
            );
          });
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget divider = Container(height: 1, color: Colors.black);

  Widget listItem(int index) {
    return Column(children: [
      InkWell(
        onTap: () async {
          final Map _contactdata = _chats_list.removeAt(index);
          _chats_list.insert(0, _contactdata);
          print('b');

          setState(() {
            _chats_list = _chats_list;
          });

          _chat_activity = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                contactdata: _contactdata,
                myId: widget.userdata['id'],
              ),
            ),
          );
          if (_chat_activity == 'reload') {}
        },
        child: Container(
          height: 100,
          padding: EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/test2.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _chats_list[index]["fullname"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _chats_list[index]["lastchat"],
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                child: Text('Date'),
              )
            ],
          ),
        ),
      ),
      divider,
    ]);
  }
}
