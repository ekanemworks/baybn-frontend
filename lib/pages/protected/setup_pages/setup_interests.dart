import 'package:baybn/pages/layouts/membersview.dart';
import 'package:baybn/pages/protected/setup_pages/setup_profilephoto.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SetupInterests extends StatefulWidget {
  Map userdata;
  SetupInterests({Key? key, required this.userdata}) : super(key: key);

  @override
  _SetupInterestsState createState() => _SetupInterestsState();
}

class _SetupInterestsState extends State<SetupInterests> {
  Map userdata = {};
  String firstname = '';
  List<String> fullname = []; // as a list/array
  List<dynamic> interestAvailable = [];
  List<dynamic> myinterest = [];

  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  @override
  void initState() {
    setState(() {
      userdata = widget.userdata;
      fullname = userdata['fullname'].split(" ");
      if (fullname.isNotEmpty) {
        firstname = fullname[0];
      }

      _fetchinterests();
    });

    super.initState();
  }

  // get INTEREST FUNCTION
  _fetchinterests() {
    httpService.fetchSetupInterests().then(
          (value) => {
            setState(() {
              interestAvailable = value;
              // print(interestAvailable);
            })
          },
        );
  }

  // SAVE INTEREST OUTSIDE FUNCTION
  // SAVE INTEREST OUTSIDE FUNCTION
  _saveinterests(List myinterest, context) {
    // HTTPS SERVICE CALL
    // HTTPS SERVICE CALL
    print('setup interest');
    print(myinterest);
    httpService.postSetupInterests(
        {'myinterest': myinterest, 'session': userdata['session']}).then(
      (value) => {
        if (value['status'] == 'ok')
          {
            sessionMgt.updateSession('interests', myinterest),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SetupProfilephoto(),
              ),
            )
          }
        else
          {_showToast(context, value['message'])}
      },
    );

    // print({'myinterest': myinterest, 'session': userdata['session']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Set up",
            style: TextStyle(
                fontSize: 19.0,
                // color: Colors.deepPurple,
                fontWeight: FontWeight.bold
                // color: Colors.white,
                ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
              child: OutlinedButton(
                onPressed: () {
                  _saveinterests(myinterest, context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ]),
      body: Container(
        constraints: BoxConstraints.expand(),
        // color: Colors.deepPurple,
        // width: 100,
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ' + firstname,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Let's get your Baybn interests all set",
                  style: const TextStyle(fontSize: 16),
                ),
                Container(
                  // color: Colors.grey.shade800,
                  margin: EdgeInsets.only(top: 20),
                  // height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          // Color.fromRGBO(247, 119, 55, 1),
                          Colors.deepOrange,
                          Color.fromRGBO(236, 72, 76, 1),
                          Color.fromRGBO(255, 48, 108, 1),
                          Color.fromRGBO(193, 53, 132, 1),
                        ]),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // color: Colors.pink,
                              child: Row(
                                children: [
                                  Text(
                                    'My Interests',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' : ' +
                                        myinterest.length.toString() +
                                        '/10',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  myinterest = [];
                                });
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(color: Colors.pink),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // Text(myinterest.toString()),

                        myinterest.length > 0
                            ? Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 5,
                                runSpacing: 5,
                                children: myinterest.map<Widget>((i) {
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade800),
                  margin: EdgeInsets.only(top: 3),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          'Select Interests',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: interestAvailable.map<Widget>((e) {
                            return Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    e['interest_category'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Wrap(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: json
                                          .decode(e['interests'])
                                          .map<Widget>((i) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (myinterest.length < 10) {
                                              setState(() {
                                                myinterest.add(i);
                                              });
                                            } else {
                                              _showToast(context,
                                                  'Maximum Interest Limit is 10');
                                            }
                                          },
                                          child: Text(
                                            i,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                        );
                                      }).toList())
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
