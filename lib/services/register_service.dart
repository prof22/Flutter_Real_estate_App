import 'package:real_estate_app/repository/repository.dart';

class RegisterService{
  Repository _repository;
  RegisterService(){
    _repository = Repository();
  }
  registerNewUser(Map data) async
  {
    return await _repository.httpPost('register', data);
  }
}