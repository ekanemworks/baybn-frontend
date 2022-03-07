import 'package:baybn/pages/private/camera_screen.dart';
import 'package:baybn/pages/public/launcher.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// import './pages/private/spikes.dart';
// import './pages/private/chats.dart';
// import './pages/private/me.dart';

void main() {
  // // THIS IS IMPORTANT FOR A CAMERA PLUGIN
  // WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();

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
        primarySwatch: Colors.deepOrange,
        // brightness: Brightness.dark,
        accentColor: Colors.deepOrange,
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
