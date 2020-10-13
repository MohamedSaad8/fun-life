import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  String labelText;
  IconData icon;
  bool obSecure;
  String password;
  Function saveData;
  CustomTextFormField(
      {this.labelText, this.icon, this.obSecure, this.password, this.saveData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: formValidator,
      onSaved: saveData,
      obscureText: obSecure,
      decoration: InputDecoration(
        suffixIcon: Icon(
          icon,
          color: Color(0xffDC3A6B),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black, letterSpacing: 1.2),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffDC3A6B)),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffDC3A6B)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // ignore: missing_return
  String formValidator(value) {
    if (labelText == "Email address") {
      if (value.isEmpty) {
        return "Email adrress is empty";
      }
      if (value.length < 5) {
        return "EmailAdrress must be > 4 characters";
      }
      if (value.length > 40) {
        return "EmailAdrress must < 20 character";
      }
    }
    if (labelText == "password") {
      if (value.isEmpty) {
        return "password adrress is empty";
      }
      if (value.length < 5) {
        return "password must be more than 4 characters";
      }
      if (value.length > 20) {
        return "password mustn\'t be more than 20 character";
      }
    }
    if (labelText == "User name") {
      if (value.isEmpty) {
        return "user name is empty";
      }
      if (value.length < 4) {
        return "user name must > 4 characters";
      }
      if (value.length > 20) {
        return "user name must < 20 character";
      }
    }
    if (labelText == "confirm password") {
      if (value.isEmpty) {
        return "confirm password name is empty";
      }
      if (value != password) {
        return "password and confirm not equals";
      }
    }
  }
}
