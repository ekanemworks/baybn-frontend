import 'package:baybn/pages/private/notificationTile.dart';
import 'package:baybn/pages/private/chats_pages/start_new_chat_contact_list_tile.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:flutter/material.dart';

class StartNewChat extends StatefulWidget {
  Map userdata;
  StartNewChat({Key? key, required this.userdata}) : super(key: key);

  @override
  State<StartNewChat> createState() => StartNewChatState();
}

class StartNewChatState extends State<StartNewChat> {
  final HttpService httpService = HttpService();

  List<dynamic> _contacts = [];

  var _matayas;
  late int _userid = 0;

  void initState() {
    getContacts(widget.userdata['id']);
    _userid = widget.userdata['id'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          // scrollDirection: Axis.horizontal,
          children: _contacts.map((e) {
            return StartNewChatTile(
                contactPersonData: e, usersId: widget.userdata['id']);
          }).toList(),
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
