import 'dart:io';

import 'package:baybn/pages/layouts/own_message_card.dart';
import 'package:baybn/pages/layouts/reply_card.dart';
import 'package:baybn/pages/model/message_model.dart';
import 'package:baybn/pages/private/camera_page.dart';
import 'package:baybn/pages/services/http_service.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  Map contactdata;
  int myId;
  ChatPage({Key? key, required this.contactdata, required this.myId})
      : super(key: key);

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  late String _displaypicture;
  late String _fullname;
  late String _lastchat;
  String _chatMessageSent = '';
  String _chatMessageReceived = '';
  final HttpService httpService = HttpService();
  late IO.Socket socketIO;
  List<MessageModel> _messages = [];
  // ScrollController listScrollController = ScrollController();

  ImagePicker _picker = ImagePicker();
  XFile? file;

  // List<Widget> _messagesB = <Widget>[new Text('hello'), new Text('world')];
  ScrollController _scrollController = ScrollController();
  // IO.Socket init(onSocketConnected, onSocketDisconnected) {

  //   // return socketIO;
  // }

  void initState() {
    _displaypicture = widget.contactdata['profilephoto'];
    _fullname = widget.contactdata['fullname'];
    // _lastchat = widget.contactdata['lastchat'];
    print('chat page');

    // USING LOCAL HOST FOR IOS AND CHROME
    // socketIO = IO.io('http://localhost:3001', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'upgrade': false
    // });

    // USING SPECIFIC IP COS ANDROID EMULATOR CAN'T SEE SHIT
    // socketIO = IO.io('http://192.168.8.197:3001', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'upgrade': false
    // });
    socketIO = IO.io('http://192.168.0.126:3001', <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });

    socketIO.connect();

    // Handle socket events
    socketIO.on('connect', (data) => print('Connected to socket server'));
    socketIO.emit("signin", widget.myId);
    socketIO.on(
        'disconnect', (reason) => print('disconnected because of $reason'));
    socketIO.on('error', (err) => print('Error: $err'));
    setUpSocketListener();
    super.initState();
  }
  // end of initState

  void sendMessage(text) {
    // set message to message model and to messages List for appropriate display
    // set message to message model and to messages List for appropriate display
    setMessage('source', text);
    // TO SCROLL TO THE BOTTOM OF THE LIST USING A SCROLL CONTROLLER
    // TO SCROLL TO THE BOTTOM OF THE LIST USING A SCROLL CONTROLLER
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    // if (listScrollController.hasClients) {
    //   final position = listScrollController.position.maxScrollExtent;
    //   listScrollController.animateTo(
    //     position,
    //     duration: Duration(milliseconds: 1),
    //     curve: Curves.easeOut,
    //   );
    // }

    var messageJson = {
      "message": text,
      "sentByMe": socketIO.id,
      "baybnSourceId": widget.myId,
      "baybnTargetId": widget.contactdata['id'],
      "myname": _fullname
    };
    socketIO.emit('message', messageJson);
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      _messages.add(messageModel);
    });
  }

  void setUpSocketListener() {
    socketIO.on('message-received', (data) {
      // set message to message model and to messages List for appropriate display
      // set message to message model and to messages List for appropriate display
      setMessage('destination', data['message']);
      // TO SCROLL TO THE BOTTOM OF THE LIST USING A SCROLL CONTROLLER
      // TO SCROLL TO THE BOTTOM OF THE LIST USING A SCROLL CONTROLLER
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      // if (listScrollController.hasClients) {
      //   final position = listScrollController.position.maxScrollExtent;
      //   listScrollController.animateTo(
      //     position,
      //     duration: Duration(milliseconds: 1),
      //     curve: Curves.easeOut,
      //   );
      // }
      // setState(() {
      //   _chatMessageReceived = data['message'];
      // });
    });
  }

  void handleMoreDropDown(String value) {
    if (value == 'Report') {
      print('report');
    } else if (value == 'Block') {
      print('block');
    }
    // switch (value) {
    //   case 'Logout':
    //     break;
    //   case 'Settings':
    //     break;
    // }
  }

  bool _showEmoji = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _editingController = TextEditingController();
  double _textFieldbottomPadding = 28;
  double _textFieldleftPadding = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop('reload'),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _displaypicture == ''
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        'assets/test2.png',
                      ),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        httpService.serverAPI + _displaypicture,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  _fullname,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Stack(
                children: [
                  PopupMenuButton<String>(
                    onSelected: handleMoreDropDown,
                    itemBuilder: (BuildContext context) {
                      return {'Open Profile', 'Report', 'Block'}
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.blue,
        child: Column(
          children: [
            Expanded(
              // height: MediaQuery.of(context).size.height - 200,
              // padding: EdgeInsets.only(bottom: 0),
              // height: 100,
              // color: Colors.orange,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 80),
                shrinkWrap: true,
                // Scroll Controller for functionality
                controller: _scrollController,
                itemCount: _messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return Container(height: 70);
                  }
                  if (_messages[index].type == 'source') {
                    return OwnMessageCard(
                        themessage: _messages[index].message,
                        thetime: _messages[index].time);
                  } else {
                    return ReplyCard(
                        themessage: _messages[index].message,
                        thetime: _messages[index].time);
                  }

                  // return Container();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(
                      //     bottom: _textFieldbottomPadding,
                      //     left: _textFieldleftPadding),
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.yellow,
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _editingController,
                                focusNode: focusNode,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                minLines: 1,
                                maxLines: 3,
                                onChanged: (value) {
                                  _chatMessageSent = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  prefixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.emoji_emotions_outlined),
                                    onPressed: () {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        _showEmoji = !_showEmoji;

                                        // TO CONTROL THE GAP BETWEEN THE TEXTFIELD AND THE EMOJI AND THE BOTTOM OF SCREEN
                                        // TO CONTROL THE GAP BETWEEN THE TEXTFIELD AND THE EMOJI AND THE BOTTOM OF SCREEN
                                        if (_showEmoji == false) {
                                          _textFieldbottomPadding = 28;
                                          _textFieldleftPadding = 3;
                                        } else {
                                          _textFieldbottomPadding = 0;
                                          _textFieldleftPadding = 0;
                                        }
                                      });
                                    },
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.attach_file),
                                        onPressed: () async {
                                          file = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                        },
                                      ),
                                      // IconButton(
                                      //   icon: const Icon(Icons.camera_alt),
                                      //   onPressed: () {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) => CameraPage(),
                                      //       ),
                                      //     );
                                      //   },
                                      // )
                                    ],
                                  ),
                                ),
                                onSaved: (value) {},
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 8, right: 2, left: 2),
                            child: CircleAvatar(
                              radius: 25,
                              child: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  // socketConnect();

                                  if (_editingController.text != '') {
                                    sendMessage(_editingController.text);
                                    _editingController.clear();
                                    // setState(() {
                                    //   _chatMessageSent = '';
                                    // });
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Expanded(child: emojiSelect())
                    _showEmoji ? emojiSelect() : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 3,
      ),
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          setState(() {
            _editingController.text = _editingController.text + emoji.emoji;
          });
        },
        onBackspacePressed: () {
          // Backspace-Button tapped logic
          // Remove this line to also remove the button in the UI
        },
        config: Config(
            columns: 7,
            emojiSizeMax: 32 *
                1, // Issue: https://github.com/flutter/flutter/issues/28894
            verticalSpacing: 0,
            horizontalSpacing: 0,
            initCategory: Category.RECENT,
            bgColor: Color(0xFFF2F2F2),
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            progressIndicatorColor: Colors.blue,
            backspaceColor: Colors.blue,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            noRecentsText: "No Recents",
            noRecentsStyle:
                const TextStyle(fontSize: 20, color: Colors.black26),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL),
      ),
    );
  }
}
