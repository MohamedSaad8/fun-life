import 'package:funlife/models/userModel.dart';

class Comment
{
  int commentID ;
  String commentContent;
  User commentUser;

  Comment({this.commentID, this.commentContent, this.commentUser});
}