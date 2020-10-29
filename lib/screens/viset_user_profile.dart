import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funlife/models/userModel.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class VisitProfile extends StatelessWidget {
  final User searchedUser;
  VisitProfile({this.searchedUser});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextStyle _style1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      searchedUser.userState != null
                          ? userStateUI(screenWidth, context)
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      userInformationUI(screenWidth, _style1, context),
                      SizedBox(
                        height: 10,
                      ),
                      userBio(screenWidth, context),
                    ],
                  );
                }
                if (index == 1) {
                  return subTitle(screenWidth, screenHeight, _style1, "Posts");
                }
                return searchedUser.userPosts.length > 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              searchedUser.userProfileImageUrL),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              searchedUser.userName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Publish from android",
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              postContentUI(searchedUser
                                  .userPosts[index - 2].postContent),
                              postImageUI(
                                  screenWidth,
                                  context,
                                  searchedUser
                                      .userPosts[index - 2].postImageURL),
                              likeCommentButtonsUI(),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: screenWidth,
                        child: Center(
                          child: Text(
                            "No Posts till now",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
              },
              itemCount: searchedUser.userPosts.length == 0
                  ? 3
                  : searchedUser.userPosts.length + 2,
            ),
          ),
          SizedBox(
            height: 46,
          ),
        ],
      ),
    );
  }

  userStateUI(screenWidth, BuildContext context) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(vertical: 5),
      height: 40,
      decoration: BoxDecoration(
        color: kMainColor,
      ),
      child: Center(
        child: Text(
          searchedUser.userState,
          style:
              TextStyle(color: Colors.white, letterSpacing: 1.1, fontSize: 16),
        ),
      ),
    );
  }

  userInformationUI(screenWidth, style1, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: kMainColor,
                backgroundImage: searchedUser.userProfileImageUrL == null
                    ? null
                    : NetworkImage(searchedUser.userProfileImageUrL),
                radius: screenWidth / 8,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                searchedUser.userName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                          searchedUser.userPosts.length == null
                              ? "0"
                              : searchedUser.userPosts.length.toString(),
                          style: style1),
                      SizedBox(
                        height: 5,
                      ),
                      Text("posts"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                          searchedUser.followers.length == null
                              ? "0"
                              : searchedUser.followers.length.toString(),
                          style: style1),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Followers"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                          searchedUser.following.length == null
                              ? "0"
                              : searchedUser.following.length.toString(),
                          style: style1),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Following"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: screenWidth / 2,
                child: FlatButton(
                  onPressed: () {},
                  color: kMainColor,
                  textColor: Colors.white,
                  child: Text("Follow"),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  userBio(screenWidth, BuildContext context) {
    return searchedUser.userBio != null
        ? Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: Text(
                  searchedUser.userBio,
                  style: TextStyle(
                      color: Colors.black, fontSize: 15, letterSpacing: 1.2),
                ),
              ),
            ],
          )
        : Container();
  }

  postContentUI(String postContent) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Wrap(
        children: <Widget>[
          postContent == null
              ? Container()
              : Text(
                  postContent,
                  style: TextStyle(fontSize: 15, letterSpacing: 1.4),
                ),
        ],
      ),
    );
  }

  likeCommentButtonsUI() {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Like",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.thumb_up,
                    color: Colors.grey,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Comment",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.comment,
                    color: Colors.grey,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  postImageUI(screenWidth, BuildContext context, String postImageURL) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: screenWidth, minHeight: screenWidth / 15),
      child: postImageURL == null
          ? Container()
          : Image(
              image: NetworkImage(postImageURL),
              fit: BoxFit.cover,
            ),
    );
  }

  subTitle(
      double screenWidth, double screenHeight, TextStyle style1, String title) {
    return Container(
      padding: EdgeInsets.all(10),
      width: screenWidth,
      height: screenHeight / 20,
      color: Colors.grey[300],
      child: Text(
        title,
        style: style1,
      ),
    );
  }
}
