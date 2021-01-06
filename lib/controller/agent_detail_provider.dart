import 'package:flutter/foundation.dart';
import 'package:real_estate_app/models/agent.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/get_agent_service.dart';

class AgentDetailsProvider with ChangeNotifier{
  GetAgentService _agentService = GetAgentService();

  List<Agent> _agentList = List<Agent>();

int agentId;
AgentDetailsProvider();

List<Agent>  get agentDetails{
  return[..._agentList];
}

Agent findByid(int agentId)
{
  return [..._agentList].firstWhere((agent) => agent.id == agentId );
}




void setAgentDetails(int agentId) async {
    var responseJson = await _agentService.getAgentDetails(agentId);

    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
  
    } else {
      responseJson['data'].forEach((data) {
        var model = Agent();
        model.id = data['id'];
        model.name = data['name'];
        model.username = data['username'];
        model.image = Imgurl.imageUrl + data['image'];
        model.email = data['email'];
        model.phone = data['phone'];
        model.sex = data['sex'];
        model.address = data['address'];
        model.height = data['height'];
        model.age = data['age'];
        model.city = data['city'];
        model.state = data['state'];
        model.country = data['country'];
        model.about = data['about'];
            _agentList.add(model);
            notifyListeners();
      
      });
    }
  }
}