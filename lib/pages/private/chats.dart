import 'package:baybn/pages/private/chats_pages/chart_page.dart';
import 'package:flutter/material.dart';

import 'chats_pages/start_new_chat_contact_list.dart';

class Chats extends StatefulWidget {
  Map userdata;
  Chats({Key? key, required this.userdata}) : super(key: key);

  @override
  State<Chats> createState() => ChatsState();
}

class ChatsState extends State<Chats> {
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
    setState(() {});
    print(_active_chats);
    super.initState();
  }

  reArrangeList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _active_chats.isEmpty
          ? Center(
              child: OutlinedButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                },
                child: const Text(
                    'Your chat is empty, All Chats will appear here'),
              ),
            )
          : Center(
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: _active_chats.map((e) {
                  return listItem(_active_chats.indexOf(e));
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StartNewChat(),
              ),
            );
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget divider = Container(height: 1, color: Colors.black);

  Widget listItem(int index) {
    return Column(children: [
      InkWell(
        onTap: () async {
          final Map _contactdata = _active_chats.removeAt(index);
          _active_chats.insert(0, _contactdata);
          print('b');

          setState(() {
            _active_chats = _active_chats;
          });

          _chat_activity = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(contactdata: _contactdata),
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
                          _active_chats[index]["fullname"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _active_chats[index]["lastchat"],
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
