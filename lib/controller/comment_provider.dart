import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:real_estate_app/models/comment.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/comment_count_services.dart';

class CommentProvider with ChangeNotifier{

  List<Comments> commentList = List<Comments>();
  bool isloading = true;

  // CommentProvider(){
  //  commentList = commentList;
  // }

  // setData(List<Comments> _comment){
  //   commentList = _comment;
  //   isloading = false;
  //   notifyListeners();
  // }

  List<Comments> getData(){
    return commentList;
  }


 Future<List<Comments>> getAllComment (String slug) async{
    var getComment = CommentCountService();
    var response = await getComment.getComments(slug);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result['users'].forEach((user) {
        var model = Comments();
        // model.id = user['id'];
        model.body = user['body'];
        model.userName = user['users']['name'];
        model.image = Imgurl.usersUrl + user['users']['image'];
        commentList.add(model);
        isloading = false;
        notifyListeners();
      });
    }
    return commentList;
  

  }
  
}