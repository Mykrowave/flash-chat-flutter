import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChatScreen extends StatefulWidget {
  static const ScreenName = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isWaiting = false;
  TextEditingController _chatTextController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _store = Firestore.instance;
  FirebaseUser _user;

  void getCurrentUser() async {
    _user = await _auth.currentUser();
    print(_user.email);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                if (_user != null) {
                  await _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomeScreen.ScreenName, (rdr) => false);
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isWaiting,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: _store.collection('messages').snapshots(),
                  builder: (context, qs) {
                    if (!qs.hasData)
                      return CircularProgressIndicator();
                    else {
                      List<TextMessage> textMessages = new List<TextMessage>();
                      qs.data.documents.reversed.forEach((d) {
                        String message = d.data['text'];
                        String sender = d.data['sender'];

                        var newWidget = new TextMessage(
                          self:
                              _user.email.toUpperCase() == sender.toUpperCase(),
                          sender: sender,
                          message: message,
                        );
                        textMessages.add(newWidget);
                      });

                      // textMessages.sort((a,b){
                      //   return a.message.compareTo(b.message);
                      // });

                      return Expanded(
                        child: ListView(
                          reverse: true,
                          children: textMessages,
                        ),
                      );
                    }
                  },
                ),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _chatTextController,
                          onChanged: (value) {
                            //Do something with the user input.
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            _isWaiting = true;
                          });
                          await _store.collection('messages').add({
                            'text': _chatTextController.text,
                            'sender': _user.email
                          });

                          setState(() {
                            _isWaiting = false;
                          });
                        },
                        child: Text(
                          'Send',
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  final bool self;
  final String sender;
  final String message;

  const TextMessage({
    Key key,
    @required this.message,
    this.self,
    this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: self ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment:
                self ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                sender,
                style: TextStyle(fontSize: 12.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Material(
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(message, textAlign: TextAlign.left),
                  ),
                  color: self ? Colors.lightBlue : Colors.orange,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
