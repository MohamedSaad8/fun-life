import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:dio/dio.dart';

class UploadImage extends StatefulWidget {
  static String id = "upload";

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File imageFile ;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius:  100,
                backgroundImage: imageFile == null ? null : FileImage(imageFile),
              ),
              RaisedButton(
                child: Text("get image from camera"),
                onPressed: getImage
              ),
              RaisedButton(
                  child: Text("get image from gallery"),
                  onPressed: getImageFromGallery
              ),
              RaisedButton(
                  child: Text("Upload to database"),
                  onPressed: uploadToDataBase
              ),

            ],
          ),
        ),
      ),
    );
  }

  void getImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(image.path) ;
    });
  }
  void getImageFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image.path) ;
    });
  }

  void uploadToDataBase() async {
    String url = "http://192.168.1.9:1337/upload";
    Map<String, String> headers = {
      "refId" : "1",
      "ref" : "user",
      "field" : "profileImage",
      "source" : "users-permissions"
    };
    var request = new http.MultipartRequest("POST", Uri.parse(url),);
    request.files.add(
      await http.MultipartFile.fromPath(
        "files",
        imageFile.path,
      ),
    );

    print(imageFile.path);
    request.fields.addAll(headers);
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
      print(response.statusCode);
    }).catchError((e) => print(e));

  }
}
