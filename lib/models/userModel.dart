class User
{
  int userID;
  String email;
  String userName;
  String password;
  String userToken ;
  String userState;
  String userBio;
  DateTime userBirthDate;
  static User currentUser;

  User({this.userID, this.email, this.userName, this.password, this.userToken,
      this.userState, this.userBio, this.userBirthDate});


}