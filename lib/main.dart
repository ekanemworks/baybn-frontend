import 'package:baybn/pages/layouts/membersview.dart';
import 'package:baybn/pages/public/launcher.dart';
import 'package:flutter/material.dart';

// import './pages/private/spikes.dart';
// import './pages/private/chats.dart';
// import './pages/private/me.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // brightness: Brightness.dark,
        accentColor: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Baybn'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return const MembersView(title: 'Baybn');
    return const LauncherPage();
  }
}
