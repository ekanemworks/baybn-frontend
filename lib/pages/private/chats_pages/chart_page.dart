import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ChatPage extends StatefulWidget {
  Map contactdata;
  ChatPage({Key? key, required this.contactdata}) : super(key: key);

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

  late IO.Socket socketIO;

  // IO.Socket init(onSocketConnected, onSocketDisconnected) {

  //   // return socketIO;
  // }

  void initState() {
    _displaypicture = widget.contactdata['displaypicture'];
    _fullname = widget.contactdata['fullname'];
    _lastchat = widget.contactdata['lastchat'];
    print('chat page');

    socketIO = IO.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });

    socketIO.connect();

    // Handle socket events
    socketIO.on('connect', (data) => print('Connected to socket server'));
    socketIO.on(
        'disconnect', (reason) => print('disconnected because of $reason'));
    socketIO.on('error', (err) => print('Error: $err'));
    setUpSocketListener();
    super.initState();
  }

  void sendMessage(text) {
    var messageJson = {
      "message": text,
      "sentByMe": socketIO.id,
      "myname": _fullname
    };
    socketIO.emit('message', messageJson);
  }

  void setUpSocketListener() {
    socketIO.on('message-receive', (data) {
      print(data['message']);

      setState(() {
        _chatMessageReceived = data['message'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop('reload'),
        ),
        title: Text(_fullname),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 200,
              color: Colors.red,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text('data'),
                  Text('data'),
                  Text(_chatMessageReceived),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      color: Colors.yellow,
                      width: MediaQuery.of(context).size.width - 60,
                      child: Card(
                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
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
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.emoji_emotions_outlined),
                              onPressed: () {
                                // socketConnect();
                              },
                            ),
                          ),
                          onSaved: (value) {
                            // _chatMessage = value!;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8, right: 2, left: 2),
                      child: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            // socketConnect();
                            sendMessage(_chatMessageSent);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
