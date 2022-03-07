import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard(
      {Key? key, required this.themessage, required this.thetime})
      : super(key: key);

  // const LauncherPageView({Key? key}) : super(key: key);
  final String themessage;
  final String thetime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Colors.deepPurple,
          child: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 60, top: 8, bottom: 24),
              child: Text(
                themessage,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Row(
                children: [
                  Text(
                    thetime,
                    style: TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.done_all, size: 20),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
