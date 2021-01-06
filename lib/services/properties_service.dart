import 'package:real_estate_app/repository/repository.dart';


class PropertiesService{
  Repository _repository;

  PropertiesService(){
    _repository = Repository();
  }
  allproperties() async{
    return await _repository.httpGet('allproperties');
  }
  frontProperties() async{
    return await _repository.httpGet('frontProperties');
  }
  bedroom() async{
    return await _repository.httpGet('bedroom');
  }
   bathroom() async{
    return await _repository.httpGet('bathroom');
  }

// search(String city, String apartment, String purpose, int bedroom,
//  int bathroom, String minPrice, String maxPrice) async{
//   return await _repository.httpGetsearch(city, apartment, purpose, bedroom, bathroom, minPrice, maxPrice);
// }
search(String city, String apartment, String purpose, int bedroom, int bathroom,
String minPrice, String maxPrice) async{
  return await _repository.httpGet('search?city=$city&type=$apartment&purpose=$purpose&bedroom=$bedroom&bathroom=$bathroom&minprice=$minPrice&maxprice=$maxPrice');
}
  

  getRelatedProperty(String slug) async{
    return await _repository.httpGetRealtedProperty(slug);
  }
}