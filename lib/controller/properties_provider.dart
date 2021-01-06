import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/models/sliderModel.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/properties_service.dart';
import 'package:real_estate_app/services/property_image_service.dart';
import 'package:real_estate_app/services/property_service.dart';
import 'package:real_estate_app/services/rating_service.dart';



class PropertiesProvider with ChangeNotifier{

PropertyService _propertyService = PropertyService();
PropertyImageService _propertyImageService = PropertyImageService();
PropertiesService _propertiesService = PropertiesService();

PropertiesProvider(){
  _getAllFeaturedProperties();
  _getAllPropertiesList();
  _getPropertiesImage();
  _getAllFrontProperties();
   getRating();
}

List<Properties> _featuredPropertiesList = List();
List<Properties> _propertyImageList = List();
List<Properties> _allFrontPropertyList = List();
List<Properties> _allPropertyList = List();
List<Properties> _getPropertyId = List();

List<Properties> get featuredPropertiesList{
  return[..._featuredPropertiesList];
}
List<Properties> get propertyImageList{
  return[..._propertyImageList];
}

List<Properties> get allFrontPropertyList{
  return[..._allFrontPropertyList];
}
List<Properties> get allPropertyList{
  return[..._allPropertyList];
}

Properties findByid(int id)
{
  return _getPropertyId.firstWhere((property) => property.id == id );
}

double propertyrating;

double get rating {
  return propertyrating;
}

void  _getAllFeaturedProperties() async {
    var responseJson = await _propertyService.getfeaturedProperties();
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
        print(Imgurl.imageUrl + data['image']);
         _featuredPropertiesList.add(model);
         _getPropertyId.add(model);
         notifyListeners();
});
}

void  _getPropertiesImage() async {
    var responseJson = await _propertyImageService.allpropertyImage();
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
         _propertyImageList.add(model);
          _getPropertyId.add(model);
         notifyListeners();
});
}

void  _getAllFrontProperties() async {
    var responseJson = await _propertiesService.frontProperties();
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
         _allFrontPropertyList.add(model);
          _getPropertyId.add(model);
           notifyListeners();
});
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

 getRating() async{
    var getRating = RatingService();
    var response = await getRating.getRating();
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result['data'].forEach((data) {
       data['rating'].forEach((rating){
          print(propertyrating);
          propertyrating = double.parse(rating['rating']);       
        notifyListeners();
       });
        
      });
    }
 }
}