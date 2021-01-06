import 'package:real_estate_app/repository/repository.dart';

class PostCommentService{
  Repository _repository;
  PostCommentService(){
    _repository = Repository();
  }
  postComment(String token, int id, Map data) async
  {
    return await _repository.httpPostcomment(token, id, data);
  }
}