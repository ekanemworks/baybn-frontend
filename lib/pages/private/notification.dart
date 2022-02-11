import 'package:baybn/pages/private/chats_pages/chart_page.dart';
import 'package:baybn/pages/private/notificationTile.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:flutter/material.dart';

import 'chats_pages/start_new_chat_contact_list.dart';

class Notifications extends StatefulWidget {
  Map userdata;
  Brightness? appmode;
  Notifications({Key? key, required this.userdata, required this.appmode})
      : super(key: key);

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  List<dynamic> _chats_list = [];
  // List<dynamic> _notification_list = [
  //   {"displaypicture": "s", "fullname": "Michael", "lastchat": "s"},
  //   {"displaypicture": "s", "fullname": "Mom2", "lastchat": "s"},
  //   {"displaypicture": "s", "fullname": "Josh", "lastchat": "s"},
  //   {"displaypicture": "s", "fullname": "Geepee", "lastchat": "s"},
  //   {"displaypicture": "s", "fullname": "Mfon Bassey", "lastchat": "s"},
  //   {"displaypicture": "s", "fullname": "Moyo", "lastchat": "s"},
  //   {"displaypicture": "s", "fullname": "Jessica", "lastchat": "s"},
  // ];
  List<dynamic> _notification_list = [];
  final HttpService httpService = HttpService();

  String _chat_activity = '';

  void initState() {
    getNotification(widget.userdata['id']);

    super.initState();
  }

  getNotification(_id) {
    httpService.fetchNotificationRequestValues(_id).then(
          (value) => {
            setState(() {
              if (value['status'] == 'ok') {
                _notification_list = value['body'];
                print(_notification_list);
              }
            })
          },
        );
  }

  reArrangeList() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: widget.appmode,
        accentColor: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop('reload'),
          ),
          title: const Text("Notification"),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: _notification_list.isEmpty
                ? Center(
                    child: Text('Notification Empty'),
                  )
                : Center(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('Add Requests',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: ListView(
                            // scrollDirection: Axis.horizontal,
                            children: _notification_list.map((e) {
                              return NotificationTile(
                                  notificationDatalist: e,
                                  usersId: widget.userdata['id']);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
