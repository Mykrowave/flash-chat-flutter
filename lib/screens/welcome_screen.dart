import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/roundedbutton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const ScreenName = "WelcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            new RoundedButton(
              color: Colors.lightBlueAccent,
              buttonText: 'Log In',
              buttonCallBack: () => Navigator.pushNamed(context, LoginScreen.ScreenName),
            ),
            new RoundedButton(
              color: Colors.blueAccent,
              buttonText: 'Register',
              buttonCallBack: () => Navigator.pushNamed(context, RegistrationScreen.ScreenName),
            )
          ],
        ),
      ),
    );
  }
}


