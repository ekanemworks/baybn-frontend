import 'package:baybn/pages/protected/setup_pages/setup_interests.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Setup1 extends StatefulWidget {
  Map userdataparameter;
  Setup1({Key? key, required this.userdataparameter}) : super(key: key);

  @override
  _Setup1State createState() => _Setup1State();
}

class _Setup1State extends State<Setup1> {
  Map userdata = {};

  final HttpService httpService = HttpService();

  @override
  void initState() {
    setState(() {
      userdata = widget.userdataparameter;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext contextt) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
        accentColor: Colors.deepPurple,
      ),
      home: SetupInterests(
        userdata: userdata,
      ),
    );
  }
}
