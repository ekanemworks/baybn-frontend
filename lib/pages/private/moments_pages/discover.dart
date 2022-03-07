import 'dart:convert';
import 'package:baybn/pages/private/moments_pages/makefriend_tile.dart';
import 'package:baybn/pages/private/moments_pages/makefriends.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';

class DiscoverPeople extends StatefulWidget {
  DiscoverPeople({Key? key}) : super(key: key);

  @override
  State<DiscoverPeople> createState() => DiscoverPeopleState();
}

class DiscoverPeopleState extends State<DiscoverPeople> {
  final HttpService httpService = HttpService();
  late String _session = "";
  late int _userid = 0;
  late Map _userdata;
  List<dynamic> _baybn_members = [];
  final SessionManagement sessionMgt = SessionManagement();

  @override
  void initState() {
    _fetchMembers();
    callSession();
    super.initState();
  }

  callSession() {
    // use session management class to set session
    // use session management class to set session
    sessionMgt.getSession().then(
          (value) => {
            setState(() {
              // decode

              _userdata = json.decode(value);
              _userid = _userdata['id'];
              // print(_userdata['id']);
              _session = _userdata['session'];
              // print(_session);
            })
          },
        );
  }

  void _fetchMembers() {
    httpService.fetchActiveMembersPopular({"session": _session}).then(
      (value) => {
        setState(() {
          _baybn_members = value['body'];
          // print(interestAvailable);
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // backgroundColor: Color(0x44000000),
        // foregroundColor: Colors.indigo,
        title: const Text("Discover People"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: _baybn_members.isNotEmpty
            ? Column(
                children: [
                  MakeFriends(),
                ],
              )
            : CircularProgressIndicator(),
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
