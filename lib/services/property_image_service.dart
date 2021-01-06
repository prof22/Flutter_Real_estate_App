import 'package:real_estate_app/repository/repository.dart';

class PropertyImageService{
  Repository _repository;

  PropertyImageService(){
    _repository = Repository();
  }
  allpropertyImage() async{
    return await _repository.httpGet('propertyimage');
  }

    allpropertyCity(String city) async{
    return await _repository.httpGetCity(city);
  }
}