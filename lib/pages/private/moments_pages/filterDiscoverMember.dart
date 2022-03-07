import 'dart:convert';

import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FilterDiscoverMember extends StatefulWidget {
  FilterDiscoverMember({Key? key}) : super(key: key);

  @override
  State<FilterDiscoverMember> createState() => FilterDiscoverMemberState();
}

class FilterDiscoverMemberState extends State<FilterDiscoverMember> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  final SessionManagement sessionMgt = SessionManagement();

  String initialGender = 'Gender';
  String initialSchool = 'University / School';
  String initialCountry = 'Country';
  String initialProfileType = 'Profile Type';
  String initialInterest = 'Interest';
  String _session = '';

  final List genderList = [
    'Gender',
    'Everyone',
    'Male',
    'Female',
  ];

  List schoolList = [
    'University / School',
    '',
  ];

  List countryList = [
    'Country',
    '',
  ];

  List profileTypeList = [
    'Profile Type',
    '',
    'Student',
    'Graduate',
  ];

  List interestList = [
    'Interest',
    '',
  ];

  List<dynamic> interestAvailable = [];
  List interestList1 = [];
  List interestList2 = [];
  List interestList3 = [];

  @override
  void initState() {
    _fetchSignupCriteria();
    _fetchinterests();
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
              _session = json.decode(value)['session'];
            })
          },
        );
  }

  void _fetchSignupCriteria() {
    httpService.fetchSignupCriteria().then((value) => {
          // print(value['countries']),
          // print(['Country', 'Nigeria', 'Ghana', 'South Africa']),
          setState(() {
            countryList = json.decode(value['countries']);
            schoolList = json.decode(value['universities']);
          })
        });
  }

  // get INTEREST FUNCTION
  void _fetchinterests() {
    httpService.fetchSetupInterests().then(
          (value) => {
            setState(() {
              interestAvailable = value;
              interestList1 = json.decode(interestAvailable[0]['interests']);
              interestList2 = json.decode(interestAvailable[1]['interests']);
              interestList3 = json.decode(interestAvailable[2]['interests']);

              interestList.addAll(interestList1);
              interestList.addAll(interestList2);
              interestList.addAll(interestList3);
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          // color: Colors.purple,
          height: 400,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: DropdownButton(
                    value: initialGender,
                    isExpanded: true,
                    onChanged: (dynamic value) {
                      setState(() {
                        initialGender = value!;
                      });
                    },
                    items: genderList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    value: initialSchool,
                    isExpanded: true,
                    onChanged: (dynamic value) {
                      setState(() {
                        initialSchool = value!;
                      });
                    },
                    items: schoolList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    value: initialCountry,
                    isExpanded: true,
                    onChanged: (dynamic value) {
                      setState(() {
                        initialCountry = value!;
                      });
                    },
                    items: countryList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    value: initialProfileType,
                    isExpanded: true,
                    onChanged: (dynamic value) {
                      setState(() {
                        initialProfileType = value!;
                      });
                    },
                    items: profileTypeList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    value: initialInterest,
                    isExpanded: true,
                    onChanged: (dynamic value) {
                      setState(() {
                        initialInterest = value!;
                      });
                    },
                    items: interestList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: 180, // <-- Your width
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      // backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text(
                      'Use Filter',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      if (initialGender == 'Gender') {
                        _showToast(context, "Select a value for Gender");
                      } else {
                        var mapData = {
                          'gender': initialGender,
                          'school': initialSchool,
                          'country': initialCountry,
                          'profiletype': initialProfileType,
                          'interests': initialInterest,
                          'session': _session
                        };
                        // print(mapData);
                        Navigator.of(context).pop(mapData);
                      }
                    },
                  ),
                ),

                // Text(mapdata.toString()),
              ],
            ),
          ),
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
    // print(context);
  }
}
