import 'package:flutter/cupertino.dart';

class LoginRegisterMode extends ChangeNotifier
{
  bool inLoginMode = true;

  changeLoginRegisterMode()
  {
    inLoginMode = !inLoginMode ;
    notifyListeners();
  }

}