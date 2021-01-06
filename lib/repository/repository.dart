import 'dart:convert';
import 'package:http/http.dart' as http;


class Repository
{
  String _baseUrl = "http://192.168.8.100:8000/api";
  // String _baseUrl = "http://10.0.2.2:8000/api/";
  httpGet(String api) async
  {
    try{
    final response = await http.get(_baseUrl + "/" + api,   
    headers: {
          'Accept':'application/json',
          'Content-Type':'application/json'
      },);
    if (response.statusCode == 401 || response.statusCode == 400 || response.statusCode == 500 || response.statusCode == 502 || response.statusCode == 503) 
    {
      
      throw Exception('Unauthenticated');
      
  
       }else if( response.statusCode == 200) {
          // print(_baseUrl + "/" + api);
      final responseJson = json.decode(response.body);
     
      return responseJson;
    }else{
      throw Exception('Failed to load internet');
    }

    } catch (exception) {
  
      if(exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
  }
  }
//Post Comment without UserId
 httpPost(String api, Map data) async
  { 
  return  await http.post(_baseUrl + "/" + api, body: data);
}

//Login 
httpLogin(String api, Map data) async
{
  return await http.post(_baseUrl + "/" + api,
    headers:{
          'Accept':'application/json',
          'Content-Type':'application/json',
          // 'Authorization': 'Bearer $token'
      },
   body: data);
}

//Logout
httpLogout(String token, api)async
{
  return await http.post(_baseUrl + "/" + api,
    headers:{
          'Accept':'application/json',
          'Content-Type':'application/json',
          'Authorization': 'Bearer $token'
      },
   body: null);
}

//comment Count and message Count
httpComment(String api, token)async
{
 return await http.get(_baseUrl + "/" + api,
    headers:{
          'Accept':'application/json',
          'Content-Type':'application/json',
          'Authorization': 'Bearer $token'
      });
}
//Post with Token
httpPostToken(String token, Map data)async
{
  
  var postData = await http.post(_baseUrl + "/changePasswordUpdate",
    headers:{
          'Accept':'application/json',
          //  'Content-Type':'application/json',
          'Authorization': 'Bearer $token'
      },
   body: data);
  //  print(postData);
    return postData;
}

//post comment
httpPostcomment(String token, int id, Map data)async
{
  
  var postData = await http.post(_baseUrl + "/property/comment/$id",
    headers:{
          'Accept':'application/json',
          //  'Content-Type':'application/json',
          'Authorization': 'Bearer $token'
      },
   body: data);
  //  print(postData);
    return postData;
}

//get Users Comment
httpGetComments(String slug) async
{
  final response =  await http.get(_baseUrl + '/propertieshow/$slug',
   headers: {
          'Accept':'application/json',
          'Content-Type':'application/json'
      },);
      // print(_baseUrl + '/propertieshow/$slug');
   return response;
}
//Check Agent
httpCheckAgent(String api, token)async
{
 return await http.get(_baseUrl + "/" + api,
    headers:{
          'Accept':'application/json',
          'Content-Type':'application/json',
          'Authorization': 'Bearer $token'
      });
}

//get rating
httpGetRating() async
{
  final response =  await http.get(_baseUrl + '/showrating',
   headers: {
          'Accept':'application/json',
          'Content-Type':'application/json'
      },);
      // print(_baseUrl + '/showrating');
   return response;
}


httpPostRating(String token, Map data)async
{
  
  var postData = await http.post(_baseUrl + "/propertyRating",
    headers:{
          'Accept':'application/json',
          //  'Content-Type':'application/json',
          'Authorization': 'Bearer $token'
      },
   body: data);
  //  print(postData);
    return postData;
}

//get Related Property
httpGetRealtedProperty(String slug) async
{
  final response =  await http.get(_baseUrl + '/relatedProperty/$slug',
   headers: {
          'Accept':'application/json',
          'Content-Type':'application/json'
      },);
      // print(_baseUrl + '/propertieshow/$slug');
   return response;
}

httpGetCity(String city) async
{
  final response =  await http.get(_baseUrl + '/propertyCity/$city',
   headers: {
          'Accept':'application/json',
          'Content-Type':'application/json'
      },);
      // print(_baseUrl + '/propertieshow/$slug');
   return response;
}
}