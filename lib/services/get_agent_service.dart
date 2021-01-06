import 'package:real_estate_app/repository/repository.dart';

class GetAgentService{
  Repository _repository;

  GetAgentService(){
    _repository = Repository();
  }
  getAgentDetails(int id) async{
    return await _repository.httpGet('agentid/'+ id.toString());
  }

  checkAgent(var token) async{
    return await _repository.httpCheckAgent('checkagent', token);
  }
}