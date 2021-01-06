import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/models/User.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/screen/home_screen.dart';
import 'package:real_estate_app/services/logout_service.dart';
import 'package:real_estate_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../changepassword_screen.dart';
import '../message_screen.dart';
import '../profile_screen.dart';
import '../user_dashboard.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<User> _usersList = List<User>();
  var name, authToken, commentCounts,  myName, myEmail, myUsername, aboutMe, myPic;
  var getmyName, getmyEmail, getmyUsername, getaboutMe, getmyPic;

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var logoutService = LogOutService();
    logoutService.logout(authToken);
    prefs.remove("token");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
Future<dynamic> userProfile() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
     authToken = prefs.getString('token');  
   var userProfileDetails = UserService();
    var  response = await userProfileDetails.getUserProfile(authToken);
    var result = json.decode(response.body);
   result['data'].forEach((data) {
     var model = User();
     model.name = data['name'];
     model.email = data['email'];
     model.username = data['username'];
     model.about = data['about'];
     model.image = Imgurl.usersUrl+data['image'];
     if(mounted){
      setState(() {
        _usersList.add(model);
        myName = prefs.setString('myName', data['name']);
        myEmail = prefs.setString('myEmail',data['email']);
        myUsername =prefs.setString('myUsername', data['username']);
        aboutMe = prefs.setString('aboutMe',data['about']);
        myPic = prefs.setString('myPic',Imgurl.usersUrl+data['image']);
    
      });
    }
   });
    
  }

  Future<dynamic> getDetails() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    if(mounted){
       setState(() {
        getmyName = prefs.getString('myName');
      getmyEmail = prefs.getString('myEmail');
      getmyUsername = prefs.getString('myUsername');
      getaboutMe = prefs.getString('aboutMe');
      getmyPic = prefs.getString('myPic');
     });
    }
    print('My name is $getmyName');
}
@override
void initState() { 
  super.initState();
  userProfile();
  getDetails();
}
@override
  void dispose() {
   userProfile();
   getDetails();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.0,
      child: ListView(
        // children: List.generate(this._usersList.length, (i) {
        //   return Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: getmyName == null ?Text('Please Wait...'):Text('$getmyName'),
                accountEmail: getmyEmail == null ?Text('Please Wait...'): Text('$getmyEmail'),
                currentAccountPicture: getmyPic == null? Container(
                               width: 30.0,
                               height: 10.0,
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(30.0),
                                image: DecorationImage(
                             image: AssetImage("assets/images/img17.jpg"),
                             fit: BoxFit.cover,
                             
                        )
                              ),
                             ):Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('$getmyPic')
                    )
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  getmyPic == null? Container(
                               width: 30.0,
                               height: 10.0,
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(30.0),
                                image: DecorationImage(
                             image: AssetImage("assets/images/img17.jpg"),
                             fit: BoxFit.cover,
                             
                        )))
                          : Container(
                    alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                        image: NetworkImage('$getmyPic')
                    )
                  ),
                ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                leading: Icon(Icons.dashboard),
                title: Text("Home Page"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                },
                leading: Icon(Icons.dashboard),
                title: Text("Dashboard"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageScreen()));
                },
                leading: Icon(Icons.message),
                title: Text("Messages"),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                },
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
              ),
              ListTile(
                onTap: () {
                  logout(context);
                },
                leading: Icon(Icons.lock_open),
                title: Text("Logout"),
              )
            ],
          )
        // }),
      // ),
    );
  }
}
