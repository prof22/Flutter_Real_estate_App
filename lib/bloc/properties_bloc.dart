import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/models/sliderModel.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/properties_service.dart';
import 'package:real_estate_app/services/property_gallery_service.dart';
import 'package:real_estate_app/services/property_image_service.dart';
import 'package:real_estate_app/services/property_service.dart';
import 'package:rxdart/rxdart.dart';

List<Properties> _propertiesList = List();
List<SliderModel> _sliderImage = List();
class FeaturedPropertiesBloc extends BlocBase{
 PropertyService _propertyService = PropertyService();

 StreamController<List<Properties>> _propertyController = StreamController<List<Properties>>();
 Sink<List<Properties>> get _inProperties => _propertyController.sink;
 Stream<List<Properties>> get outProperties => _propertyController.stream;

  FeaturedPropertiesBloc(){
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
        model.badge = data['badge'];
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

class AllPropertiesImageBloc extends BlocBase{
PropertyImageService _propertyImageService = PropertyImageService();

 StreamController<List<Properties>> _propertyImageController = new BehaviorSubject();
 Sink<List<Properties>> get _inImageProperties => _propertyImageController.sink;
 Stream<List<Properties>> get outImageProperties => _propertyImageController.stream;

  AllPropertiesImageBloc(){
    _getPropertiesImageBloc();
  }

void  _getPropertiesImageBloc() async {
    var responseJson = await _propertyImageService.allpropertyImage();
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
         model.badge = data['badge'];
        List rat = data['rating'];
        rat.forEach((rater){
          model.rating = double.parse(rater['rating']);
        });
        print(Imgurl.imageUrl + data['image']);
        tempProperties.add(model);
        //  _propertiesList.add(model);
});
      _propertiesList.clear();
      _propertiesList.addAll(tempProperties);
      _inImageProperties.add(_propertiesList);
}





@override
  void dispose() {// will be called automatically 
    _propertyImageController.close();
  }

}

class AllPropertiesBloc extends BlocBase{
 PropertiesService _propertiesService = PropertiesService();

 StreamController<List<Properties>> _allPropertyController = new BehaviorSubject();
 Sink<List<Properties>> get _inAllProperties => _allPropertyController.sink;
 Stream<List<Properties>> get outAllProperties => _allPropertyController.stream;

  AllPropertiesBloc(){
    _getAllProperties();
  }

void  _getAllProperties() async {
    var responseJson = await _propertiesService.frontProperties();
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
         model.badge = data['badge'];
        List rat = data['rating'];
        rat.forEach((rater){
          model.rating = double.parse(rater['rating']);
        });
        print(Imgurl.imageUrl + data['image']);
        tempProperties.add(model);
        //  _propertiesList.add(model);
});
      _propertiesList.clear();
      _propertiesList.addAll(tempProperties);
      _inAllProperties.add(_propertiesList);
}

@override
  void dispose() {// will be called automatically 
    _allPropertyController.close();
  }
}


class AllPropertiesListBloc extends BlocBase{
 PropertiesService _propertiesService = PropertiesService();

 StreamController<List<Properties>> _allPropertiesList = new BehaviorSubject();
 Sink<List<Properties>> get _inAllPropertiesList => _allPropertiesList.sink;
 Stream<List<Properties>> get outAllPropertiesList => _allPropertiesList.stream;

  AllPropertiesListBloc(){
    _getAllPropertiesList();
  }

void  _getAllPropertiesList() async {
    var responseJson = await _propertiesService.allproperties();
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
         model.badge = data['badge'];
        List rat = data['rating'];
        rat.forEach((rater){
          model.rating = double.parse(rater['rating']);
        });
        print(Imgurl.imageUrl + data['image']);
        tempProperties.add(model);
        //  _propertiesList.add(model);
});
      _propertiesList.clear();
      _propertiesList.addAll(tempProperties);
      _inAllPropertiesList.add(_propertiesList);
}

@override
  void dispose() {// will be called automatically 
    _allPropertiesList.close();
  }
}


class PropertySliderBloc extends BlocBase{
  PropertyGalleryService _propertyGalleryService = PropertyGalleryService();

 StreamController<List<SliderModel>> _propertySliderController = new BehaviorSubject();
//  Sink<List<SliderModel>> get _inPropertySlider => _propertySliderController.sink;
 Stream<List<SliderModel>> get outPropertySlider => _propertySliderController.stream;

  // PropertySliderBloc(){
  //   _getAllSliders(propertyId);
  // }


 Future<List<SliderModel>> getAllSliders(int propertyId) async {
    var responseJson = await _propertyGalleryService.getPropertiesGallery(propertyId);
      List<SliderModel> tempProperties = List();
      responseJson['data'].forEach((data) {
        print(Imgurl.imageUrl + data['name']);
         var model = SliderModel();
          model.image = Imgurl.imageUrl + data['name'];
        tempProperties.add(model);
});
      _sliderImage.clear();
      _sliderImage.addAll(tempProperties);
      // _inPropertySlider.add(_sliderImage);
      return _sliderImage;
}

@override
  void dispose() {// will be called automatically 
    _propertySliderController.close();
  }
}

abstract class Dbpa{
  Stream<List<SliderModel>> getData(String propertyid);
}

// class Slider implements Dbpa{
//   Stream<List<SliderModel>> getData(String propertyid){
//     List<SliderModel> _id = [].toList();
//     return getData;
//   }
// }