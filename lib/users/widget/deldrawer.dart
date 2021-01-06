import 'package:flutter/material.dart';
import 'package:real_estate_app/screen/home_screen.dart';
import 'package:real_estate_app/services/logout_service.dart';
import 'package:real_estate_app/users/changepassword_screen.dart';
import 'package:real_estate_app/users/message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile_screen.dart';
import '../user_dashboard.dart';
logout(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var logoutService = LogOutService();
     logoutService.logout(authToken);
      prefs.remove("token");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

Drawer drawerWidget(context) {
  return Drawer(
    elevation: 5.0,
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Emma"), 
          accountEmail: Text("mine@gmail.com"),
          ), 
          ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          },
          leading: Icon(Icons.dashboard),
          title: Text("Home Page"),
         ),
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
          },
          leading: Icon(Icons.dashboard),
          title: Text("Dashboard"),
         ),
         ListTile(
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
          },
          leading: Icon(Icons.person),
          title: Text("Profile"),
         ),
         ListTile(
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageScreen()));
          },
          leading: Icon(Icons.message),
          title: Text("Messages"),
         ),
         ListTile(
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
          },
          leading: Icon(Icons.lock),
          title: Text("Change Password"),
         ),
         ListTile(
           onTap: (){
             logout(context);
           },
          leading: Icon(Icons.lock_open),
          title: Text("Logout"),
         ),
        ],
    ),
  );
}
