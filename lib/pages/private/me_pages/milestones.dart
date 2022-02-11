import 'package:flutter/material.dart';

class Milestones extends StatefulWidget {
  Milestones({Key? key}) : super(key: key);

  @override
  State<Milestones> createState() => MilestonesState();
}

class MilestonesState extends State<Milestones> {
  List<dynamic> _active_chats = [
    {"title": "s", "company": "Michael", "description": "s"},
    {"title": "s", "company": "Michael", "description": "s"},
    {"title": "s", "company": "Michael", "description": "s"},
    {"title": "s", "company": "Michael", "description": "s"},
    {"title": "s", "company": "Michael", "description": "s"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Milestones"),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              // scrollDirection: Axis.horizontal,
              children: _active_chats.map((e) {
                return listItem(_active_chats.indexOf(e));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _active_chats[index]["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_active_chats[index]["title"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
