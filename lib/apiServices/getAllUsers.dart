import 'package:funlife/models/postsModel.dart';
import 'package:funlife/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:funlife/constants.dart';

class GetUsersInfo {
  List<User> users = [];
//------------------------------------------------------------------------------
  getAllUsers() async {
    var response = await http.get(usersURL);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var user in responseBody) {
        List<Post> userPosts = [];
        List<User> followersList = [];
        List<User> followingList = [];
        for (var post in user["posts"]) {
          Post newPost = Post(
              postID: post["id"],
              postContent: post["postContent"],
              postImageURL: post["postImage"] == null
                  ? null
                  : baseURL + post["postImage"]["url"]);
          userPosts.add(newPost);
        }
        for (var follower in user["follower"]) {
          User userFollower =
              User(userID: follower["id"], userName: follower["username"]);
          followersList.add(userFollower);
        }

        for (var following in user["following"]) {
          User userFollower =
              User(userID: following["id"], userName: following["username"]);
          followingList.add(userFollower);
        }

        User newUser = User(
            userID: user["id"],
            userName: user["username"].toString().toLowerCase(),
            userProfileImageUrL: user["profileImage"] != null
                ? baseURL + user["profileImage"]["url"]
                : null,
            userState: user["userState"] != null ? user["userState"] : null,
            email: user["email"],
            userBio: user["userBio"] != null ? user["userBio"] : null,
            userPosts: userPosts,
            following: followingList,
            followers: followersList);
        users.add(newUser);
      }
    }
    return users;
  }
}
