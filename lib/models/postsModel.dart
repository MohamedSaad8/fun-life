import 'package:funlife/models/commentModel.dart';
import 'package:funlife/models/userModel.dart';

class Post
{
  int postID ;
  String postContent ;
  User postUser;
  String postImageURL ;
  List<Comment> postComments ;

  Post({this.postID, this.postContent, this.postUser, this.postComments , this.postImageURL});
}