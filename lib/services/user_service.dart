import 'package:real_estate_app/repository/repository.dart';

class UserService{
  Repository _repository;
  UserService(){
    _repository = Repository();
  }
  getUserProfile(String token) async
  {
    try{
    return await _repository.httpComment('profile', token);
    }catch (exception){
        return exception;
    }
  }

}