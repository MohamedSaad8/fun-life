import 'package:funlife/models/postsModel.dart';

class User {
  int userID;
  String email;
  String userName;
  String password;
  String userToken;
  String userState;
  String userBio;
  String userProfileImageUrL;
  DateTime userBirthDate;
  List<Post> userPosts;
  List<User> followers;
  List<User> following;
  static User currentUser;

  User(
      {this.userID,
      this.email,
      this.userName,
      this.password,
      this.userToken,
      this.userState,
      this.userBio,
      this.userBirthDate,
      this.userProfileImageUrL,
      this.userPosts,
      this.followers,
      this.following});
}
