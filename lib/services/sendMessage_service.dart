import 'package:real_estate_app/repository/repository.dart';

class SendMessageService{
  Repository _repository;
  SendMessageService(){
    _repository = Repository();
  }
  sendMessage(Map data) async
  {
    return await _repository.httpPost('contact', data);
  }
}