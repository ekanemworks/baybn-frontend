import 'dart:convert';
import 'dart:math';
import 'package:baybn/pages/private/viewprofile_members.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:baybn/pages/services/session_management.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MomentOpenText extends StatefulWidget {
  Map person;
  int userid;
  String nowDate;
  MomentOpenText(
      {Key? key,
      required this.person,
      required this.userid,
      required this.nowDate})
      : super(key: key);

  @override
  State<MomentOpenText> createState() => MomentOpenTextState();
}

class MomentOpenTextState extends State<MomentOpenText>
    with SingleTickerProviderStateMixin {
  final HttpService httpService = HttpService();
  late Map _person = {};
  List _my_activeMoments = [];
  // TUTORIAL
  late PageController _pageController;
  late AnimationController _animController;
  late VideoPlayerController _videoController;
  int _currentIndex = 0;
  late Color generalColorTheme = Colors.black;

  @override
  void initState() {
    super.initState();
    _person = widget.person;
    _my_activeMoments = json.decode(_person['status_post_array']);
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    final firstMoment = _my_activeMoments.first;
    _loadMoment(moment: firstMoment, animateToPage: false);

    _videoController = VideoPlayerController.network('url')
      ..initialize().then((value) => setState(() {}));
    _videoController.play();

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < _my_activeMoments.length) {
            _currentIndex += 1;
            _loadMoment(moment: _my_activeMoments[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadMoment(moment: _my_activeMoments[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final momentsItem = _my_activeMoments[_currentIndex];
    return Scaffold(
        // backgroundColor: generalColorTheme,
        // appBar: AppBar(
        //     backgroundColor: Colors.transparent, // 1
        //     elevation: 0),
        body: GestureDetector(
      onTapDown: (details) {
        _onTapDown(details, _my_activeMoments[_currentIndex]);
      },
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _my_activeMoments.length,
            itemBuilder: (context, i) {
              final momentsItem = _my_activeMoments[i];
              switch (momentsItem['type']) {
                case "text":
                  // int colorLength = momentsItem['colorTheme'].length;

                  // Color _choosenThemeColor =  (momentsItem['colorTheme']);
                  // Color _choosenThemeColor = int. parse() momentsItem['colorTheme'];
                  // late Color _choosenThemeColor = Color(0xffa5d6a7);

                  String valueString = momentsItem['colorTheme']
                      .split('(0x')[1]
                      .split(')')[0]; // kind of hacky..
                  int value = int.parse(valueString, radix: 16);
                  Color otherColor = new Color(value);

                  return Container(
                    color: otherColor,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(momentsItem['text']),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 35),
                          ),
                        ),
                      ],
                    ),
                  );
                case "image":
                  return CachedNetworkImage(
                    imageUrl: 'imageUrl',
                    fit: BoxFit.cover,
                  );
                case "video":
                  if (_videoController != null &&
                      _videoController.value.isInitialized) {
                    return FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.size.width,
                        height: _videoController.value.size.height,
                        child: VideoPlayer(_videoController),
                      ),
                    );
                  }
              }
              return const SizedBox.shrink();
              // momentsItem['type'] == 'text'?
              // return const Text('')
              // :
            },
          ),
          Positioned(
            top: 40.0,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Row(
                  children: _my_activeMoments
                      .asMap()
                      .map((i, e) {
                        return MapEntry(
                          i,
                          AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: _currentIndex),
                        );
                      })
                      .values
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 1.5, vertical: 10.0),
                  child: UserInfo(
                      profilephoto: _person['profilephoto'],
                      fullname: _person['fullname']),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  void _onTapDown(TapDownDetails details, momentsItem) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadMoment(moment: momentsItem);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < _my_activeMoments.length) {
          _currentIndex += 1;
          _loadMoment(moment: momentsItem);
        } else {
          _currentIndex = 0;
          _loadMoment(moment: momentsItem);
        }
      });
    } else {
      // THIS IS FOR WHEN CENTER OF SCREEN IS TOUCHED
      // THIS IS FOR WHEN CENTER OF SCREEN IS TOUCHED
      // if (momentsItem['type'] == 'video') {
      //   if (_videoController.value.isPlaying) {
      //     _videoController.pause();
      //     _animController.stop();
      //   } else {
      //     _videoController.play();
      //     _animController.forward();
      //   }
      // }
    }
  }
  //  END OF ONTAPDOWN FUNCTION

  // moment value in the function below must be the same as in IniState() above
  void _loadMoment({moment, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();

    switch (moment['type']) {
      case "text":
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case "image":
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case "video":
        // _videoController = null;
        _videoController.dispose();
        _videoController = VideoPlayerController.network('url')
          ..initialize().then((_) {
            setState(() {});
            if (_videoController.value.isInitialized) {
              _animController.duration = _videoController.value.duration;
              _videoController.play();
              _animController.forward();
            }
          });
        break;
    }
    // End of switch statement
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar(
      {Key? key,
      required this.animController,
      required this.position,
      required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                              constraints.maxWidth * animController.value,
                              Colors.white);
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black26, width: 0.8),
          borderRadius: BorderRadius.circular(3.0)),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String profilephoto;
  final String fullname;

  UserInfo({Key? key, required this.profilephoto, required this.fullname})
      : super(key: key);

  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        profilephoto == ''
            ? CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage(
                  'assets/test2.png',
                ),
              )
            : CircleAvatar(
                radius: 20.0,
                backgroundImage: CachedNetworkImageProvider(
                    httpService.serverAPI + profilephoto),
              ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            fullname,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close, size: 30, color: Colors.white),
        )
      ],
    );
  }
}
