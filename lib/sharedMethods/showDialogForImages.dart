
import 'package:flutter/material.dart';

import '../constants.dart';

showDialogForChoseImages({BuildContext context, Function camera ,Function gallery}){
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Update Profile Image"),
          actions: <Widget>[
            FlatButton(
              color: kMainColor,
              child: Text("From Camera"),
              onPressed: (){
                camera() ;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              color: kMainColor,
              child: Text("From Gallery"),
              onPressed: (){
                gallery();
                Navigator.pop(context);
              }
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
}