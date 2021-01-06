import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/property_service.dart';


class FeaturePropertiesBloc extends BlocBase{
 List<Properties> _propertiesList = List();
 PropertyService _propertyService = PropertyService();

 StreamController<List<Properties>> _propertyController = StreamController<List<Properties>>();
 Sink<List<Properties>> get _inProperties => _propertyController.sink;
 Stream<List<Properties>> get outProperties => _propertyController.stream;

  FeaturePropertiesBloc(){
    _getAllFeaturedProperties();
  }

void  _getAllFeaturedProperties() async {
    var responseJson = await _propertyService.getfeaturedProperties();
     List<Properties> tempProperties = List();
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
        print(Imgurl.imageUrl + data['image']);
        tempProperties.add(model);
        //  _propertiesList.add(model);
});
      _propertiesList.clear();
      _propertiesList.addAll(tempProperties);
      _inProperties.add(_propertiesList);
}

@override
  void dispose() {// will be called automatically 
    _propertyController.close();
  }

}