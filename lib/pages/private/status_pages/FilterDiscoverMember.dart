import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FilterDiscoverMember extends StatefulWidget {
  FilterDiscoverMember({Key? key}) : super(key: key);

  @override
  State<FilterDiscoverMember> createState() => FilterDiscoverMemberState();
}

class FilterDiscoverMemberState extends State<FilterDiscoverMember> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String initialGender = 'Both';
  String initialSchool = 'Select School';
  String initialCountry = 'Country';
  String initialStudent = 'Position';
  String initialInterest = 'Interest';

  final List genderList = [
    'Both',
    '',
    'Male',
    'Female',
  ];

  final List schoolList = [
    'Select School',
    '',
    'Unilag',
    'Covenant',
    'Babcock',
    'OAU',
    'Bowen',
  ];

  final List countryList = [
    'Country',
    '',
    'Nigeria',
    'Ghana',
    'South-Africa',
    'Kenya',
  ];

  final List studentList = [
    'Position',
    '',
    'Student',
    'Graduate',
  ];

  final List interestList = [
    'Interest',
    '',
    'Dating',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
    'Married',
  ];

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
                    value: initialStudent,
                    isExpanded: true,
                    onChanged: (dynamic value) {
                      setState(() {
                        initialStudent = value!;
                      });
                    },
                    items: studentList.map((items) {
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

                // DropdownButton(
                //   value: myInitialItem,
                //   isExpanded: true,
                //   onChanged: (dynamic value) {
                //     setState(() {
                //       myInitialItem = value!;
                //     });
                //   },
                //   items: myItems.map((items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: Text(items),
                //     );
                //   }).toList(),
                // ),

                // DropdownButton(
                //   value: myInitialItem,
                //   isExpanded: true,
                //   onChanged: (dynamic value) {
                //     setState(() {
                //       myInitialItem = value!;
                //     });
                //   },
                //   items: myItems.map((items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: Text(items),
                //     );
                //   }).toList(),
                // ),

                // DropdownButton(
                //   value: myInitialItem,
                //   isExpanded: true,
                //   onChanged: (dynamic value) {
                //     setState(() {
                //       myInitialItem = value!;
                //     });
                //   },
                //   items: myItems.map((items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: Text(items),
                //     );
                //   }).toList(),
                // ),
                const SizedBox(height: 20),

                // Text(mapdata.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
