import 'package:flutter/material.dart';

class StartNewChat extends StatelessWidget {
  const StartNewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: [
              Container(height: 100, color: Colors.green),
              Container(height: 100, color: Colors.green),
              Container(height: 100, color: Colors.green),
              Container(height: 100, color: Colors.green),
              Container(height: 100, color: Colors.green),
            ]),
      ),
    );
  }
}
