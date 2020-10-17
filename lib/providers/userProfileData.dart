import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:funlife/constants.dart';
import 'package:funlife/models/userModel.dart';
import 'package:http/http.dart' as http;

class UserProfileData extends ChangeNotifier
{
  updateUserState(int userID , String state)async{
    Map<String,String> userState = {
      "userState" : "$state"
    };
    var response = await http.put(usersURL+"/$userID" , body: userState);
    if(response.statusCode == 200)
    {
      var currentUserInfo = jsonDecode(response.body);
      User.currentUser.userState = currentUserInfo["userState"];
      notifyListeners();

    }
  }

  updateUserBio(int userID , String bio)async{
    Map<String,String> userBio = {
      "userBio" : "$bio"
    };
    var response = await http.put(usersURL+"/$userID" , body: userBio);
    if(response.statusCode == 200)
    {
      var currentUserInfo = jsonDecode(response.body);
      User.currentUser.userBio = currentUserInfo["userBio"];
      notifyListeners();

    }
  }

  uploadToDataBase(int userID , File imageFile) async {
    String url = uploadsURL;
    Map<String, String> headers = {
      "refId" : "$userID",
      "ref" : "user",
      "field" : "profileImage",
      "source" : "users-permissions"
    };
    var request = new http.MultipartRequest("POST", Uri.parse(url),);
    request.files.add(
      await http.MultipartFile.fromPath(
        "files",
        imageFile.path,
      ),
    );
    request.fields.addAll(headers);
    request.send().then((response) async {
      if (response.statusCode == 200)
        {
          var userID = User.currentUser.userID;
          var response2 = await http.get(usersURL+"/$userID");
          var userData = jsonDecode(response2.body);
          User.currentUser.userProfileImageUrL = baseURL +  userData["profileImage"]["url"];
          notifyListeners();

        }
      print(response.statusCode);
    }).catchError((e) => print(e));

  }




}