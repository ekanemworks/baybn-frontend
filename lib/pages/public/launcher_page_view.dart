import 'package:flutter/material.dart';
import 'package:baybn/pages/public/signup_page1.dart';
import 'package:baybn/pages/widgets/app_large_text.dart';
import 'dart:convert';

class LauncherPageView extends StatefulWidget {
  const LauncherPageView({Key? key}) : super(key: key);

  @override
  _LauncherPageViewState createState() => _LauncherPageViewState();
}

class _LauncherPageViewState extends State<LauncherPageView> {
  List images = [
    "applauncher1.png",
    "applauncher.png",
    "applauncher.png",
  ];

  List topTexts = [
    'Simple Private Free',
    'Have Fun',
    'Create Connections',
  ];

  List bodyTexts = [
    // 'The Baybn is a social dd dsdsd',
    'Social messaging app where professionals build friendships, find collaborations or meet new people',
    'Catch up with friends, orgnise ',
    'Create Connections',
  ];

  List contentImages = [
    // 'The Baybn is a social dd dsdsd',
    'assets/baybncoloredwhite.png',
    'assets/applauncher_img3.png',
    'assets/applauncher_img2.png',
  ];

  String casestudy = "test1.jpg";

  PageController controller = PageController();
  var currentPageValue = 0.0;

  Map userData = {
    'session': '',
    'fullname': '',
    'username': '',
    'bio': '',
    'spikestatus_count': '',
    'friends_count': '',
    'photos': '',
  };

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // scrollDirection: Axis.vertical,
      controller: controller,
      itemCount: images.length,
      itemBuilder: (_, indexx) {
        return Container(
          width: double.maxFinite, // maximum width
          height: double.maxFinite, // maxium height
          decoration: BoxDecoration(
            // in container if you want to show a background image you need box decoration
            image: DecorationImage(
                image: AssetImage("assets/" + images[indexx]),
                fit: BoxFit.cover),
          ),

          child: Container(
            margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  // width: 150,
                  margin: const EdgeInsets.fromLTRB(10, 2, 10, 30),
                  // color: Colors.purple,
                  // child: Image.asset('assets/default.png'),
                  child: const Text(
                    'Baybn',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        // color: Colors.purple,
                        // child: Image.asset('assets/default.png'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(contentImages[indexx]),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        // color: Colors.purple,
                        width: 102,
                        height: 20,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 100, bottom: 30),
                        child: Row(
                          children: List.generate(3, (indexDots) {
                            return Container(
                              margin: const EdgeInsets.only(left: 4),
                              height: 15,
                              width: indexx == indexDots ? 30 : 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: indexx == indexDots
                                      ? Colors.deepPurple
                                      : Colors.grey.shade200),
                            );
                          }),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: AppLargeText(
                          text: topTexts[indexx],
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        // width: 300,
                        height: 100,
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: Text(
                          bodyTexts[indexx],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 19.0,
                            color: Colors.white,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        // width: 300,
                        width: double.maxFinite,
                        alignment: Alignment.center,

                        // color: Colors.red,
                        margin: const EdgeInsets.only(top: 20),
                        child: indexx == (images.length - 1)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage1(),
                                          ),
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Join Today',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 19.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                              // color: Colors.white,
                                              ),
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(5)),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Log in',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                            // color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurple),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(5)),
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                'Swipe Left',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                    // color: Colors.white,
                                    ),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
