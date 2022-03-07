import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key, required this.themessage, required this.thetime})
      : super(key: key);
  final String themessage;
  final String thetime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 0.6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // color: Colors.black,
          // color: Colors.grey.shade100,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 60, top: 7, bottom: 24),
              child: Text(
                themessage,
                style: TextStyle(
                  fontSize: 16,
                  // color: Colors.white,
                  // color: Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Text(
                thetime,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
