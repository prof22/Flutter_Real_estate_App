import 'package:real_estate_app/repository/repository.dart';

class PropertyService{
  Repository _repository;

  PropertyService(){
    _repository = Repository();
  }
  getfeaturedProperties() async{
    return await _repository.httpGet('featuredProperties');
  }
}