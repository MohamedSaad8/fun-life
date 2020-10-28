import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funlife/apiServices/authentication.dart';
import 'package:funlife/providers/login%20RegisterMode.dart';
import 'package:funlife/screens/funLiveMainScreen.dart';
import 'package:funlife/widget/customTextFormFeild.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//----------------------------------------------------------
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static String id = "LoginScreen";
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String userName;
  String password;
  String email;
  String confirmPassword;
  Auth auth = Auth();
  File userProfileImageFile;
  final picker = ImagePicker();

//----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    bool loginRegisterMode =
        Provider.of<LoginRegisterMode>(context).inLoginMode;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffDC3A6B),
      body: Stack(
        children: <Widget>[
          curvedWhiteContainer(screenWidth, screenHeight),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                appLogo(screenWidth, screenHeight, loginRegisterMode),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Builder(
                    builder: (context) => loginRegisterAccountBox(
                        screenWidth, screenHeight, loginRegisterMode, context),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 30,
                ),
                Text(
                  loginRegisterMode
                      ? "Don\'t have an account ?"
                      : "Already have account!",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<LoginRegisterMode>(context, listen: false)
                        .changeLoginRegisterMode();
                  },
                  child: Text(
                    loginRegisterMode ? "Register" : "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //-----------------------------------------------------
  AnimatedContainer loginRegisterAccountBox(double screenWidth,
      double screenHeight, bool loginRegisterMode, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
      width: screenWidth,
      height: loginRegisterMode ? screenHeight / 2.2 : screenHeight / 1.89,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xffDC3A6B), offset: Offset(-1, -1), spreadRadius: 1)
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
            key: _globalKey,
            child: Column(
              children: <Widget>[
                Text(
                  loginRegisterMode ? "Login Account" : "SignUp Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                !loginRegisterMode
                    ? SizedBox(
                        height: screenWidth / 30,
                      )
                    : Container(),
                !loginRegisterMode
                    ? CustomTextFormField(
                        labelText: "User name",
                        icon: Icons.person,
                        obSecure: false,
                        saveData: (value) {
                          userName = value;
                        },
                      )
                    : Container(),
                //------------------
                SizedBox(
                  height: screenWidth / 43,
                ),
                CustomTextFormField(
                    labelText: "Email address",
                    icon: Icons.email,
                    obSecure: false,
                    saveData: (value) {
                      email = value;
                    }),
                SizedBox(
                  height: screenWidth / 43,
                ),
                CustomTextFormField(
                    labelText: "password",
                    icon: Icons.lock,
                    obSecure: true,
                    saveData: (value) {
                      password = value;
                    }),
                SizedBox(
                  height:
                      loginRegisterMode ? screenWidth / 15 : screenWidth / 43,
                ),
                !loginRegisterMode
                    ? CustomTextFormField(
                        labelText: "confirm password",
                        icon: Icons.lock,
                        obSecure: true,
                        password: password,
                        saveData: (value) {
                          confirmPassword = value;
                        })
                    : Container(),
                SizedBox(
                  height: !loginRegisterMode ? 25 : 0,
                ),
                FlatButton(
                  color: Color(0xffDC3A6B),
                  onPressed: () async {
                    _globalKey.currentState.save();
                    if (_globalKey.currentState.validate()) {
                      var response = loginRegisterMode
                          ? await auth.userLogin(email, password)
                          : await auth.userSignUp(email, password, userName);
                      if (response != null) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response),
                          ),
                        );
                      } else {
                        Navigator.pushNamed(context, FunLifeMainScreen.id);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      loginRegisterMode ? "LOGIN" : "Register",
                      style: TextStyle(color: Colors.white, letterSpacing: 1.2),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenWidth / 30,
                ),
                loginRegisterMode
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20,
                            child: Text("OR"),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                loginRegisterMode
                    ? SizedBox(
                        height: 10,
                      )
                    : Container(),
                loginRegisterMode
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Login With Facebook",
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Login With Google",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack appLogo(
      double screenWidth, double screenHeight, bool loginRegisterMode) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: screenWidth,
          height: screenHeight / 3,
          child: Transform.scale(
            scale: .7,
            child: Image(
              image: ExactAssetImage("images/fun-live.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Text(
            loginRegisterMode
                ? "Fill The Bellow Informations To Login"
                : "Fill The Bellow Informations To Register",
            style: TextStyle(
                fontSize: 18,
                // fontFamily: "Cairo",
                color: Colors.black,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.1),
          ),
          bottom: screenHeight / 25,
        ),
      ],
    );
  }

  Transform curvedWhiteContainer(double screenWidth, double screenHeight) {
    return Transform.scale(
      scale: 1.9,
      child: Container(
        width: screenWidth,
        height: screenHeight * .5,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(screenWidth),
            bottomRight: Radius.circular(screenWidth),
          ),
        ),
      ),
    );
  }
}
