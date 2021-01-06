import 'package:flutter/material.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/properties_service.dart';

class AllPropertiesProvider with ChangeNotifier{
PropertiesService _propertiesService = PropertiesService();
List<Properties> _allPropertyList = List();
List<Properties> _getPropertyId = List();


AllPropertiesProvider(){
  _getAllPropertiesList();
}

List<Properties> get allPropertyList{
  return[..._allPropertyList];
}

void  _getAllPropertiesList() async {
    var responseJson = await _propertiesService.allproperties();
      responseJson['data'].forEach((data) {
        var model = Properties();
        model.id = data['id'];
        model.title = data['title'];
        model.price = data['price'];
        model.purpose = data['purpose'];
        model.type = data['type'];
        model.image = Imgurl.imageUrl + data['image'];
        model.bedroom = data['bedroom'];
        model.bathroom = data['bathroom'];
        model.address = data['address'];
        model.city = data['city'];
        model.area = data['area'];
        model.slug = data['slug'];
        model.description = data['description'];
        model.floorPlan = data['floor_plan'];
        model.nearBy = data['nearby'];
        model.agentId = data['agent_id'];
         model.badge = data['badge'];
        List rat = data['rating'];
        rat.forEach((rater){
          model.rating = double.parse(rater['rating']);
        });
        print(Imgurl.imageUrl + data['image']);
        _allPropertyList.add(model);
         _getPropertyId.add(model);
           notifyListeners();
});
}

}