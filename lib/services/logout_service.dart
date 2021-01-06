import 'package:real_estate_app/repository/repository.dart';

class LogOutService{
  Repository _repository;
  LogOutService(){
    _repository = Repository();
  }
  logout(String token) async
  {
    try{
    return await _repository.httpLogout('logout', token);
    }catch (exception){
        return exception;
    }
  }
}