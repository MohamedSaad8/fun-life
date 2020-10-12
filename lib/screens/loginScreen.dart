import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//----------------------------------------------------------
class LoginScreen extends StatelessWidget {
  static String id = "LoginScreen";

//----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
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
                appLogo(screenWidth, screenHeight),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: loginRegisterAccountBox(screenWidth, screenHeight),
                ),
                SizedBox(
                  height: screenHeight / 30,
                ),
                Text(
                  "Don\'t have an account ?",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: screenHeight / 50,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container loginRegisterAccountBox(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0xffDC3A6B), offset: Offset(-1, -1), spreadRadius: 1)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Form(
          child: Column(
            children: <Widget>[
              Text(
                "Login Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenWidth / 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.email,
                    color: Color(0xffDC3A6B),
                  ),
                  labelText: "Email address",
                  labelStyle:
                      TextStyle(color: Color(0xffDC3A6B), letterSpacing: 1.2),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffDC3A6B)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: screenWidth / 43,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Color(0xffDC3A6B),
                  ),
                  labelStyle:
                      TextStyle(color: Color(0xffDC3A6B), letterSpacing: 1.2),
                  labelText: "password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xffDC3A6B)),
                  ),
                ),
              ),
              SizedBox(
                height: screenWidth / 15,
              ),
              FlatButton(
                color: Color(0xffDC3A6B),
                onPressed: () {
                  print(screenWidth);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, letterSpacing: 1.2),
                  ),
                ),
              ),
              SizedBox(
                height: screenWidth / 30,
              ),
              Row(
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
              ),
              SizedBox(
                height: 10,
              ),
              Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack appLogo(double screenWidth, double screenHeight) {
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
            "Fill The Bellow Informations To Login",
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
