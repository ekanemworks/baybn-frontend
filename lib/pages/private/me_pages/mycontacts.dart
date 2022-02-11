import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:flutter/material.dart';

class MyContacts extends StatefulWidget {
  Map userdata;
  MyContacts({Key? key, required this.userdata}) : super(key: key);

  @override
  State<MyContacts> createState() => MyContactsState();
}

class MyContactsState extends State<MyContacts> {
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
      body: _contacts.isEmpty
          ? Center(
              child: OutlinedButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                },
                child: const Text(
                    'Your chat is empty, All Chats will appear here'),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3),
                children: _contacts.map((e) {
                  return listItem(e);
                }).toList(),
              ),
            ),
    );
  }

  Widget divider = Container(height: 1, color: Colors.black);

  Widget listItem(_value) {
    print(_value);

    var firstname = _value['fullname'].split(" ");
    if (firstname.isNotEmpty) {
      firstname = firstname[0];
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _value['profilephoto'] == ''
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                      'assets/test2.png',
                    ),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      httpService.serverAPI + _value['profilephoto'],
                    ),
                  ),
            Container(
              // color: Colors.green,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                firstname,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              // color: Colors.green,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: InkWell(
                onTap: () async {
                  _matayas = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewProfile(
                              profileData: _value,
                              userid: _userid,
                              sourcePage: ''),
                        ),
                      ) ??
                      '';
                },
                child: Text('@' + _value['username'],
                    style: TextStyle(fontSize: 15.0, color: Colors.grey)),
              ),
            ),

            // Container(
            //   height: 70,
            //   // color: Colors.pink,
            //   child: Text(
            //     _value['bio'],
            //   ),
            // ),
            Container(
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    onPressed: () async {
                      _matayas = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewProfile(
                                  profileData: _value,
                                  userid: _userid,
                                  sourcePage: ''),
                            ),
                          ) ??
                          '';
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.chat,
                        size: 30,
                      ),
                      onPressed: () {
                        print('e');
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
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
