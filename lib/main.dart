import 'package:flutter/material.dart';
import 'package:funlife/screens/loginScreen.dart';
import 'package:funlife/screens/onBoardingScreen.dart';

void main() => runApp(FunLife());

class FunLife extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OnBoardingScreen.id,
      routes: {
        OnBoardingScreen.id : (context) => OnBoardingScreen(),
        LoginScreen.id : (context) => LoginScreen()
      },
    );
  }
}

