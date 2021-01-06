import 'package:real_estate_app/repository/repository.dart';

class RatingService{
  Repository _repository;
  RatingService(){
    _repository = Repository();
  }
  

  getRating() async{
    return await _repository.httpGetRating();
  }
  sendRating(String token, Map data) async{
    return await _repository.httpPostRating(token, data);
  }
}