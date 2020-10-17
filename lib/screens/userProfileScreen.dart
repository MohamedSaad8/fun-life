import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funlife/providers/userProfileData.dart';
import 'package:funlife/constants.dart';
import 'package:funlife/models/userModel.dart';
import 'package:funlife/screens/loginScreen.dart';
import 'package:funlife/sharedMethods/getImages.dart';
import 'package:provider/provider.dart';

//-----------------------------------------------------------
// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  String userState;
  String userBIO;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  File userProfileImageFile;

//-----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProfileData>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    //------------------------------------------------------
    TextStyle _style1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kMainColor,
        ),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        bottom: PreferredSize(
          child: Container(color: kMainColor, height: 1),
          preferredSize: Size.fromHeight(1),
        ),
        title: Text(
          "FUN❤️LIFE",
          style: TextStyle(
              fontSize: 22, color: kMainColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Are you sure to LogOut"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                          User.currentUser = null;
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: kMainColor,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: kMainColor,
                      ),
                    ],
                  );
                });
          },
          icon: Icon(
            Icons.subdirectory_arrow_left,
            color: kMainColor,
          ),
        ),
      ),
      endDrawer: Drawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      userStateUI(screenWidth, provider, context),
                      SizedBox(
                        height: 10,
                      ),
                      userInformationUI(
                          screenWidth, _style1, context, provider),
                      SizedBox(
                        height: 10,
                      ),
                      userBio(screenWidth, provider, context),
                    ],
                  );
                }
                if (index == 1) {
                  return subTitle(screenWidth, screenHeight, _style1, "Posts");
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        postImageUI(screenWidth, context),
                        postContentUI(),
                        likeCommentButtonsUI(),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
          SizedBox(
            height: 46,
          ),
        ],
      ),
    );
  }

  InkWell postImageUI(double screenWidth, context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: screenWidth,
        height: screenWidth / 2,
        child: Image.asset(
          "images/Happy.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Padding postContentUI() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Wrap(
        children: <Widget>[
          Text(
            "my name is mohamed saad shata my name is mohamed saad shata my name is mohamed saad shata my name is mohamed saad shata",
            style: TextStyle(fontSize: 15, letterSpacing: 1.4),
          ),
        ],
      ),
    );
  }

  Row likeCommentButtonsUI() {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              child: Center(
                child: Icon(Icons.thumb_up),
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: kMainColor),
                  right: BorderSide(color: kMainColor),
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              child: Center(
                child: Icon(Icons.comment),
              ),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: kMainColor),
                    bottom: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding userBio(
      double width, UserProfileData provider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      child: User.currentUser.userBio != null
          ? InkWell(
              onTap: () {
                showDialogForUserStateAndBio(
                    context, provider, "Update My Bio", 2);
              },
              child: Wrap(
                children: <Widget>[
                  Text(
                    User.currentUser.userBio,
                    style: TextStyle(
                        color: Colors.black, fontSize: 15, letterSpacing: 1.2),
                  ),
                ],
              ),
            )
          : ButtonTheme(
              minWidth: width,
              buttonColor: Colors.grey[300],
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  showDialogForUserStateAndBio(
                      context, provider, "Update My Bio", 2);
                },
                child: Text("Add Your Bio"),
              ),
            ),
    );
  }

  Container subTitle(double screenWidth, double screenHeight, TextStyle _style1,
      String title) {
    return Container(
      padding: EdgeInsets.all(10),
      width: screenWidth,
      height: screenHeight / 20,
      color: Colors.grey[300],
      child: Text(
        title,
        style: _style1,
      ),
    );
  }

  Row userInformationUI(
      double screenWidth, TextStyle _style1, context, provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Update Profile Image"),
                        actions: <Widget>[
                          FlatButton(
                            color: kMainColor,
                            child: Text("From Camera"),
                            onPressed: () async {
                              userProfileImageFile =
                                  File(await getImageFromCamera());
                              provider.uploadToDataBase(User.currentUser.userID,
                                  userProfileImageFile);
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            color: kMainColor,
                            child: Text("From Gallery"),
                            onPressed: () async {
                              userProfileImageFile =
                                  File(await getImageFromGallery());
                              Navigator.pop(context);
                              provider.uploadToDataBase(User.currentUser.userID,
                                  userProfileImageFile);
                            },
                          ),
                          FlatButton(
                            color: Colors.red,
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: CircleAvatar(
                backgroundColor: kMainColor,
                backgroundImage: User.currentUser.userProfileImageUrL == null
                    ? null
                    : NetworkImage(User.currentUser.userProfileImageUrL),
                radius: screenWidth / 8,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              User.currentUser.userName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text("100", style: _style1),
            SizedBox(
              height: 5,
            ),
            Text("posts"),
          ],
        ),
        Column(
          children: <Widget>[
            Text("100", style: _style1),
            SizedBox(
              height: 5,
            ),
            Text("Followers"),
          ],
        ),
        Column(
          children: <Widget>[
            Text("100", style: _style1),
            SizedBox(
              height: 5,
            ),
            Text("Following"),
          ],
        ),
      ],
    );
  }

  InkWell userStateUI(
      double screenWidth, UserProfileData provider, BuildContext context) {
    return InkWell(
      onTap: () {
        showDialogForUserStateAndBio(context, provider, "Update My State", 1);
      },
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: 5),
        height: 40,
        decoration: BoxDecoration(
          color: kMainColor,
        ),
        child: Center(
          child: Text(
            User.currentUser.userState == null
                ? "Add New State"
                : User.currentUser.userState,
            style: TextStyle(
                color: Colors.white, letterSpacing: 1.1, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future showDialogForUserStateAndBio(
      BuildContext context, UserProfileData provider, String title, int fun) {
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: globalKey,
          child: AlertDialog(
            title: Text(title),
            content: Container(
              height: 100,
              width: 300,
              child: TextFormField(
                maxLines: 3,
                onSaved: (value) {
                  fun == 1 ? userState = value : userBIO = value;
                },
                maxLength: fun == 1 ? 50 : 150,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kMainColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kMainColor),
                  ),
                  hintText: fun == 1 ? "my state" : "My bio",
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  globalKey.currentState.save();
                  fun == 1
                      ? provider.updateUserState(
                          User.currentUser.userID, userState)
                      : provider.updateUserBio(
                          User.currentUser.userID, userBIO);
                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
                color: kMainColor,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
                color: kMainColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
