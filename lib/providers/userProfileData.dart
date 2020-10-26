import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:funlife/constants.dart';
import 'package:funlife/models/postsModel.dart';
import 'package:funlife/models/userModel.dart';
import 'package:http/http.dart' as http;

class UserProfileData extends ChangeNotifier {
  int postID;
  String URl;

  updateUserState(int userID, String state) async {
    Map<String, String> userState = {"userState": "$state"};
    var response = await http.put(usersURL + "/$userID", body: userState);
    if (response.statusCode == 200) {
      var currentUserInfo = jsonDecode(response.body);
      User.currentUser.userState = currentUserInfo["userState"];
      notifyListeners();
    }
  }

  updateUserBio(int userID, String bio) async {
    Map<String, String> userBio = {"userBio": "$bio"};
    var response = await http.put(usersURL + "/$userID", body: userBio);
    if (response.statusCode == 200) {
      var currentUserInfo = jsonDecode(response.body);
      User.currentUser.userBio = currentUserInfo["userBio"];
      notifyListeners();
    }
  }

  uploadToDataBase(
      {int userID, File imageFile, String ref, String field, int mode}) async {
    String url = uploadsURL;
    Map<String, String> headers = mode == 1
        ? {
            "refId": "$userID",
            "ref": ref,
            "field": field,
            "source": "users-permissions"
          }
        : {
            "refId": "$userID",
            "ref": ref,
            "field": field,
          };
    var request = new http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        "files",
        imageFile.path,
      ),
    );
    request.fields.addAll(headers);
    request.send().then((response) async {
      if (response.statusCode == 200) {
        if (mode == 1) {
          var userID = User.currentUser.userID;
          var response2 = await http.get(usersURL + "/$userID");
          var userData = jsonDecode(response2.body);
          User.currentUser.userProfileImageUrL =
              baseURL + userData["profileImage"]["url"];
          notifyListeners();
        }
        if (mode == 2) {
          print("mohaemd saad");
          var res = await response.stream.bytesToString();
          print("saad");
          var resBody = jsonDecode(res);
          print("shata");
          URl = baseURL + resBody[0]["url"];
          print(URl);
         // notifyListeners();
        }
        // var r =  await response.stream.bytesToString();
        // var j = jsonDecode(r);
        //url = j["name"];
        //  print(j);

      }
      print(response.statusCode);
    }).catchError((e) => print(e));
  }

  uploadPost(String postContent, int userID, File image, provider) async {
    Map<String, String> data = {
      "postContent": postContent,
      "users_permissions_user": "$userID"
    };

    var response = await http.post(postsURl, body: data);
    if (response.statusCode == 200) {
      print("Done");
      var responseBody = jsonDecode(response.body);
      postID = responseBody["id"];
      provider.uploadToDataBase(
          ref: "post",
          mode: 2,
          field: "postImage",
          userID: postID,
          imageFile: image);
      print("url is  $URl");
      Post post = Post(
          postContent: postContent,
          postUser: User.currentUser.userID,
          postID: responseBody["id"],
          postImageURL: URl);
      URl = null;
      User.currentUser.userPosts.add(post);
      notifyListeners();
      return postID;
    } else
      print(response.statusCode.toString());
  }
}
