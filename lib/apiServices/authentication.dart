import 'dart:convert';
import 'package:funlife/constants.dart';
import 'package:funlife/models/postsModel.dart';
import 'package:funlife/models/userModel.dart';
import 'package:http/http.dart' as http;

class Auth {
  List<Post> userPosts = [];
  List<User> followersList = [];
  List<User> followingList = [];

  userLogin(String email, String password) async {
    Map<String, String> userData = {"identifier": email, "password": password};
    var response = await http.post(loginURL, body: userData);
    if (response.statusCode == 200) {
      var currentUserInfo = jsonDecode(response.body);
      for (var post in currentUserInfo["user"]["posts"]) {
        Post newPost = Post(
            postID: post["id"],
            postContent: post["postContent"],
            postImageURL: baseURL + post["postImage"]["url"]);
        userPosts.add(newPost);
      }
      for (var follower in currentUserInfo["user"]["follower"]) {
        User userFollower =
            User(userID: follower["id"], userName: follower["username"]);
        followersList.add(userFollower);
      }
      for (var following in currentUserInfo["user"]["following"]) {
        User userFollower =
            User(userID: following["id"], userName: following["username"]);
        followingList.add(userFollower);
      }

      User user = User(
          email: email,
          password: password,
          userToken: currentUserInfo["jwt"],
          userName: currentUserInfo["user"]["username"],
          userState: currentUserInfo["user"]["userState"],
          userID: currentUserInfo["user"]["id"],
          userBio: currentUserInfo["user"]["userBio"],
          userProfileImageUrL: currentUserInfo["user"]["profileImage"] == null
              ? null
              : currentUserInfo["user"]["profileImage"]["url"],
          userPosts: userPosts,
          followers: followersList,
          following: followingList);

      User.currentUser = user;
    }
    if (response.statusCode == 400) {
      return "email or password invalid";
    }
  }

  userSignUp(String email, String password, String userName) async {
    Map<String, String> userData = {
      "email": email,
      "password": password,
      "username": userName
    };
    var response = await http.post(signUpURL, body: userData);
    if (response.statusCode == 200) {
      var currentUserInfo = jsonDecode(response.body);
      for (var post in currentUserInfo["user"]["posts"]) {
        Post newPost = Post(
            postID: post["id"],
            postContent: post["postContent"],
            postImageURL: baseURL + post["postImage"]["url"]);
        userPosts.add(newPost);
      }
      for (var follower in currentUserInfo["user"]["follower"]) {
        User userFollower =
            User(userID: follower["id"], userName: follower["username"]);
        followersList.add(userFollower);
      }
      for (var following in currentUserInfo["user"]["following"]) {
        User userFollower =
            User(userID: following["id"], userName: following["username"]);
        followingList.add(userFollower);
      }

      User user = User(
          email: email,
          password: password,
          userToken: currentUserInfo["jwt"],
          userName: currentUserInfo["user"]["username"],
          userState: currentUserInfo["user"]["userState"],
          userID: currentUserInfo["user"]["id"],
          userBio: currentUserInfo["user"]["userBio"],
          userProfileImageUrL: currentUserInfo["user"]["profileImage"] == null
              ? null
              : currentUserInfo["user"]["profileImage"]["url"],
          userPosts: userPosts,
          followers: followersList,
          following: followingList);
      User.currentUser = user;
    }
    if (response.statusCode == 400) {
      return "Email is already taken";
    }
  }
}
