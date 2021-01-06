import 'package:real_estate_app/repository/repository.dart';

class LoginService{
  Repository _repository;
  LoginService(){
    _repository = Repository();
  }
  login(Map data) async
  {
    return await _repository.httpPost('login', data);
  }
}