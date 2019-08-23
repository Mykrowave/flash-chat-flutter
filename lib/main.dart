import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.ScreenName,
      routes: {
        LoginScreen.ScreenName: (context) => LoginScreen(),
        ChatScreen.ScreenName: (context) => ChatScreen(),
        RegistrationScreen.ScreenName: (context) => RegistrationScreen(),
        WelcomeScreen.ScreenName: (context) => WelcomeScreen(),

      },
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     body1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      home: WelcomeScreen(),
    );
  }
}
