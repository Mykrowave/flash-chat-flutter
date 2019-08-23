import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/roundedbutton.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const ScreenName = "RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _pwTextController = new TextEditingController();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              keyboardType: TextInputType.emailAddress,
              controller: _emailTextController,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _pwTextController,
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              buttonText: 'Register',
              color: Colors.blueAccent,
              buttonCallBack: () async {
                AuthResult authResult =
                    await _fireBaseAuth.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _pwTextController.text);
                if (authResult.user != null)
                  Navigator.pushNamed(context, ChatScreen.ScreenName);
              },
            )
          ],
        ),
      ),
    );
  }
}
