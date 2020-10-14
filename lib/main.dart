import 'package:flutter/material.dart';
import 'package:funlife/providers/login%20RegisterMode.dart';
import 'package:funlife/screens/funLiveMainScreen.dart';
import 'package:funlife/screens/loginScreen.dart';
import 'package:funlife/screens/onBoardingScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(FunLife());

class FunLife extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginRegisterMode>(
          create: (context) => LoginRegisterMode(),
        ),
      ],
      child: MaterialApp(
        initialRoute: OnBoardingScreen.id,
        routes: {
          OnBoardingScreen.id : (context) => OnBoardingScreen(),
          LoginScreen.id : (context) => LoginScreen(),
          FunLifeMainScreen.id : (context) => FunLifeMainScreen()
        },
      ),
    );
  }
}

