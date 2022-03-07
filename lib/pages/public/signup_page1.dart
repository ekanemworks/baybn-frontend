import 'package:baybn/pages/public/signup_page2.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage1 extends StatefulWidget {
  const SignupPage1({Key? key}) : super(key: key);

  @override
  _SignupPage1State createState() => _SignupPage1State();
}

class _SignupPage1State extends State<SignupPage1> {
  String stringResponse = '1';
  List<String> listResponse = [];

  String myInitialCountry = 'Country';
  List myCountries = ["Country"];

  String myInitialSchool = 'University / School';
  List mySchools = ['University / School'];

  late String _yearofbirth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpService httpService = HttpService();

  @override
  void initState() {
    httpService.fetchSignupCriteria().then((value) => {
          // print(value['countries']),
          // print(['Country', 'Nigeria', 'Ghana', 'South Africa']),
          setState(() {
            myCountries = json.decode(value['countries']);
            mySchools = json.decode(value['universities']);
          })
        });

    // print(listResponse);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Get Started",
          style: TextStyle(
              fontSize: 19.0,
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold
              // color: Colors.white,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          // color: Colors.deepPurple,
          // width: 100,
          margin: const EdgeInsets.only(left: 40, right: 40),
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton(
                  value: myInitialCountry,
                  isExpanded: true,
                  onChanged: (dynamic value) {
                    setState(() {
                      myInitialCountry = value!;
                    });
                  },
                  items: myCountries.map((items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Year of birth (must be above 18)'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the year you were born';
                    }
                    int? birthyear = int.tryParse(value);
                    if (birthyear == null || birthyear <= 0) {
                      return 'Enter a numerical value';
                    }
                  },
                  onSaved: (value) {
                    _yearofbirth = value!;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownButton(
                  value: myInitialSchool,
                  isExpanded: true,
                  onChanged: (dynamic value) {
                    setState(() {
                      myInitialSchool = value!;
                    });
                  },
                  items: mySchools.map((items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 180, // <-- Your width
                  height: 45,
                  child: ElevatedButton(
                    child: const Text(
                      'Next',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      // print(_age);
                      // print(myInitialItem);

                      var mapdata = {
                        'yearofbirth': _yearofbirth,
                        'country': myInitialCountry,
                        'university': myInitialSchool
                      };

                      if (myInitialCountry == 'Country') {
                        if (myCountries.length == 1) {
                          _showToast(context,
                              "Your Network is terrible, didn't load countries");
                        } else {
                          _showToast(context,
                              "You have to be from one of the listed countries");
                        }
                      } else {
                        if (myInitialSchool == 'University / School') {
                          if (mySchools.length == 1) {
                            _showToast(context,
                                "Your Network is terrible, didn't load countries");
                          } else {
                            _showToast(context,
                                "You have to be from one of the Universities");
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage2(
                                mapdataparameter: mapdata,
                              ),
                            ),
                          );
                        }
                      }

                      // print(mapdata);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
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
