import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funlife/constants.dart';
import 'package:funlife/models/userModel.dart';
import 'package:funlife/providers/userProfileData.dart';
import 'package:funlife/sharedMethods/getImages.dart';
import 'package:funlife/sharedMethods/showDialogForImages.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  File postImage;
  String postContent;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProfileData>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        title: Text(
          "NEW POST",
          style: TextStyle(color: kMainColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight / 20,
              child: Text(
                "Add a Photo to your Post",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[500]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                onTap: () {
                  showDialogForChoseImages(
                      context: context,
                      camera: () async {
                        var postImageFile = File(await getImageFromCamera());
                        setState(() {
                          postImage = postImageFile;
                        });
                      },
                      gallery: () async {
                        File postImageFile = File(await getImageFromGallery());
                        setState(() {
                          postImage = postImageFile;
                        });
                      });
                },
                child: Container(
                  height: screenHeight / 2.5,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Transform.scale(
                    scale: postImage == null ? .8 : 1,
                    child: Image(
                      image: postImage == null
                          ? ExactAssetImage("images/uploadPhoto.png")
                          : FileImage(postImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: screenHeight / 20,
              child: Text(
                "Add a text content to your Post",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[500]),
              ),
            ),
            Form(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: screenWidth,
                  child: TextFormField(
                    onSaved: (value) {
                      postContent = value;
                    },
                    cursorColor: kMainColor,
                    style:
                        TextStyle(color: Colors.grey[800], letterSpacing: 1.2),
                    maxLines: null,
                    maxLength: 300,
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      filled: true,
                      hintText: "Post Content",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: screenWidth / 2,
              height: 40,
              child: RaisedButton(
                textColor: kMainColor,
                onPressed: () async {
                  globalKey.currentState.save();
                  var postID = await provider.uploadPost(postContent,
                      User.currentUser.userID, postImage, provider);
                  print(postID);
                },
                child: Text(
                  "Publish",
                  style: TextStyle(fontSize: 18),
                ),
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: screenHeight / 11,
            )
          ],
        ),
      ),
    );
  }
}
