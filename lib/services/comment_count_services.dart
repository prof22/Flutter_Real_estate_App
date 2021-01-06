import 'package:real_estate_app/repository/repository.dart';

class CommentCountService{
  Repository _repository;
  CommentCountService(){
    _repository = Repository();
  }
  countComment(String token) async
  {
    try{
    return await _repository.httpComment('commentCount', token);
    }catch (exception){
        return exception;
    }
  }

  comment(String token) async
  {
    try{
    return await _repository.httpComment('comment', token);
    }catch (exception){
        return exception;
    }
  }

  getComments(String slug) async{
    return await _repository.httpGetComments(slug);
  }
}