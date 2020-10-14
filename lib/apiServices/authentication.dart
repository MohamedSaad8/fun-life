import 'dart:convert';
import 'package:funlife/constants.dart';
import 'package:funlife/models/userModel.dart';
import 'package:http/http.dart' as http;

class Auth
{

  userLogin(String email , String password) async {
    Map<String ,String> userData = {
        "identifier": email,
        "password": password
    };

      var response = await http.post(loginURL , body: userData);
      if(response.statusCode == 200)
      {
        var currentUserInfo = jsonDecode(response.body);
        User user = User(
          email: email,
          password: password,
          userToken: currentUserInfo["jwt"],
          userName: currentUserInfo["user"]["username"]
        );
        User.currentUser = user;
      }
      if(response.statusCode == 400)
        {
          return "email or password invalid" ;
        }
  }

  userSignUp (String email , String password ,String userName) async {
    Map<String ,String> userData = {
      "email": email,
      "password": password,
      userName : userName
    };
    var response = await http.post(signUpURL , body: userData);
    if(response.statusCode == 200)
    {
      var currentUserInfo = jsonDecode(response.body);
      User user = User(
          email: email,
          password: password,
          userToken: currentUserInfo["jwt"],
          userName: currentUserInfo["user"]["username"]
      );
      User.currentUser = user;
    }
    if(response.statusCode == 400)
    {
      return "Email is already taken" ;
    }

  }

}