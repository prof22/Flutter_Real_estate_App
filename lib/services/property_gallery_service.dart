import 'package:real_estate_app/repository/repository.dart';

class PropertyGalleryService{
  Repository _repository;

  PropertyGalleryService(){
    _repository = Repository();
  }
  getPropertiesGallery(int id) async{
    return await _repository.httpGet('getGallerybyId/'+ id.toString());
  }
}