import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate_app/repository/declarations.dart';
// import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/screen/home_screen.dart';
import 'package:real_estate_app/services/logout_service.dart';
import 'package:real_estate_app/users/widget/drawers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File sampleImage;
  var authToken, name;
  String state = "";
  final txtname = TextEditingController();
  final txtemail = TextEditingController();
  final txtusername = TextEditingController();
  final txtabout = TextEditingController();

  



  @override
  void initState() {
    super.initState();
    _fetchAndRedirect(context);
  }

  @override
  void dispose() {
    super.dispose();
    _fetchAndRedirect(context);
  }

  void _fetchAndRedirect(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        name = prefs.getString('name');
        authToken = prefs.getString('token');
      });
    }
    print('Name from login screen is $name');
    print('Token from login screen is $authToken');
    print(authToken);
    if (authToken == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var tokens = prefs.getString('token');
    prefs.remove("token");
    var logoutService = LogOutService();
    logoutService.logout(authToken);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

uploadImage() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var token = prefs.getString('token');
    var stream =
        new http.ByteStream(DelegatingStream.typed(sampleImage.openRead()));
    // get file length
    var length = await sampleImage.length(); //sampleImage is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(Imgurl.urlApi+"/profileUpdate");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file
    var multipartFileSign = new http.MultipartFile('image', stream, length,
        filename: basename(sampleImage.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['name'] = txtname.text;
    request.fields['email'] = txtemail.text;
    request.fields['username'] = txtusername.text;
    request.fields['abour'] = txtabout.text;
   // request.fields['lastName'] = 'efg';

    // send
    var response = await request.send();

    print(response.statusCode);
   response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
}
// uploadImageWithhttp() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//    var token = prefs.getString('token');
//     var postBody= {
//          "name": txtemail.text,  
//         'username': txtusername.text,  
//         "email": txtemail.text,             
//         "about": txtabout.text,             
//         'image': sampleImage != null ? base64Encode(sampleImage.readAsBytesSync()) : '',
//     };

//     final response = await http.post(
//       Imgurl.urlApi+"/profileUpdate",
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type' : 'application/json',
//         'Accept' : 'application/json',
//       },
//       body: json.encode(postBody),
//     );
//     final responseJson = json.decode(response.body);
//     print(responseJson);
//   }
  
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[updateScreen()],
            )),
      ),
    );
  }

  Center updateScreen() {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            controller: txtname,
            decoration: InputDecoration(
                hintText: "Enter Name", prefixIcon: Icon(Icons.person)),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: txtusername,
            decoration: InputDecoration(
                hintText: "Username", prefixIcon: Icon(Icons.person_pin)),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: txtemail,
            decoration: InputDecoration(
                hintText: "Email", prefixIcon: Icon(Icons.lock)),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: txtabout,
            decoration: InputDecoration(
                hintText: "About", prefixIcon: Icon(Icons.lock)),
          ),
          Center(
            child: sampleImage == null
                ? Text('No image selected.')
                : Image.file(sampleImage),
          ),

          Container(
            color: Colors.blueAccent,
            child: FlatButton(onPressed: getImage, child: Text('Select Profile Photo'))),
          //       FlatButton(
          //         onPressed: () async {
          //   var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          //   var res = await uploadImage(file.path);
          //   setState(() {
          //     state = res;
          //     print(res);
          //   });
          // },
          //         child: null),

          Container(
            width: 250.0,
            margin: EdgeInsets.only(top: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.pink[200],
            ),
            child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  uploadImage();
                },
                child: Text("Update Profile")),
          ),
        ],
      ),
    );
  }
}
