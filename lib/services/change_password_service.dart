import 'package:real_estate_app/repository/repository.dart';

class ChangePasswordService{
  Repository _repository;
  ChangePasswordService(){
    _repository = Repository();
  }
  changePassword(String token, Map data) async
  {
    return await _repository.httpPostToken(token,  data);
  }
}