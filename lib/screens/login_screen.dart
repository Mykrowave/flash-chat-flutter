import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const ScreenName = "LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isWaiting = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _pwTextController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null)
      Navigator.pushReplacementNamed(context, ChatScreen.ScreenName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isWaiting,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Email',
                  )),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  controller: _pwTextController,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password',
                  )),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                buttonText: 'Log in',
                buttonCallBack: () async {
                  setState(() {
                    _isWaiting = true;
                  });
                  AuthResult authResult =
                      await _auth.signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _pwTextController.text);

                  if (authResult.user != null) {
                    setState(() {
                      _isWaiting = false;
                    });
                    Navigator.pushNamed(context, ChatScreen.ScreenName);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
