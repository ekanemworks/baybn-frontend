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

  String myInitialItem = 'Country';

  List<dynamic> myItems = ['Country'];

  late String _yearofbirth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpService httpService = HttpService();

  @override
  void initState() {
    httpService.fetchSignupCountries().then((value) => {
          setState(() {
            myItems = value;
          })
        });

    // print(listResponse);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.deepPurple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Get Started",
          style: TextStyle(
              fontSize: 19.0,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold
              // color: Colors.white,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      // body: Container(
      //   margin: const EdgeInsets.fromLTRB(20, 13, 20, 7),
      //   child: Text(stringResponse.toString()),
      // ),
      // body: FutureBuilder(
      //   future: httpService.fetchData(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.hasData) {
      //       stringResponse = snapshot.data.toString();
      //       return Text(stringResponse);
      //     } else {
      //       return const CircularProgressIndicator();
      //     }
      //   },
      // ),
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
                  value: myInitialItem,
                  isExpanded: true,
                  onChanged: (dynamic value) {
                    setState(() {
                      myInitialItem = value!;
                    });
                  },
                  items: myItems.map((items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Year of birth'),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();

                    // print(_age);
                    // print(myInitialItem);

                    var mapdata = {
                      'yearofbirth': _yearofbirth,
                      'country': myInitialItem,
                    };

                    if (myInitialItem == 'Country') {
                      _showToast(context,
                          "You have to be from one of the listed countries");
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

                    // print(mapdata);
                  },
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
