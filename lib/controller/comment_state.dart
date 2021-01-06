import 'dart:convert';



import 'package:real_estate_app/models/comment.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/comment_count_services.dart';


 getAllComment (String propertySlug) async{
    List<Comments> commentList = List<Comments>();
    var getComment = CommentCountService();
    var response = await getComment.getComments(propertySlug);
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
      
      });
    }
    return commentList;
  }
