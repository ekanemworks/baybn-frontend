import 'dart:convert';
import 'package:baybn/pages/private/chats_pages/chart_page.dart';
import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class StartNewChatTile extends StatefulWidget {
  Map contactPersonData;
  int usersId;
  StartNewChatTile(
      {Key? key, required this.contactPersonData, required this.usersId})
      : super(key: key);

  @override
  State<StartNewChatTile> createState() => StartNewChatTileState();
}

class StartNewChatTileState extends State<StartNewChatTile> {
  late Map _person = {};
  late int _userid;
  String display1 = 'true';
  String _chat_activity = '';
  final HttpService httpService = HttpService();

  var _matayas;

  @override
  void initState() {
    // TODO: implement initState
    _person = widget.contactPersonData;
    _userid = widget.usersId;
    print('_userid');
    print(_userid);
    super.initState();
  }

  void _startChat(person) async {
    // print('Baybn is worth 71 Million naira now!');

    _chat_activity = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChatPage(contactdata: widget.contactPersonData, myId: _userid),
      ),
    );
    if (_chat_activity == 'reload') {}
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _startChat(_person);
      },
      child: Card(
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
                      child: Text(
                        _person["username"],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
            ],
          ),
        ),
      ),
    );
    // return Center(child: const Text('ekanem'));
  }
}
