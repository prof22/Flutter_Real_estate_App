import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/services/change_password_service.dart';
import 'package:real_estate_app/users/widget/drawers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final txtNewPasswordConfirmation = TextEditingController();
  final txtoldPassword = TextEditingController();
  final txtnewPassword = TextEditingController();
  
   updatePassword() async {
    Map data = {
      'currentpassword': txtoldPassword.text,
      'newpassword': txtnewPassword.text,
      'newpassword_confirmation': txtNewPasswordConfirmation.text,
    };
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var changePassword = ChangePasswordService();
    var response = await changePassword.changePassword(authToken, data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result['message']);
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: DrawerWidget(),
       appBar: AppBar(
         title:Text("Change Password")
       ),
       body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[passwordChangeScreen()],
            )),
      ),
    );
  }
Center passwordChangeScreen() {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            obscureText: true,
            controller: txtoldPassword,
            decoration: InputDecoration(
                hintText: "Enter Old Password", prefixIcon: Icon(Icons.lock)),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            obscureText: true,
            controller: txtnewPassword,
            decoration: InputDecoration(
                hintText: "New Password", prefixIcon: Icon(Icons.person_pin)),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            obscureText: true,
            controller: txtNewPasswordConfirmation,
            decoration: InputDecoration(
                hintText: "Password Confirmation", prefixIcon: Icon(Icons.lock)),
          ),
          SizedBox(
            height: 20.0,
          ),
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
                  updatePassword();
                },
                child: Text("Change Password")),
          ),
        ],
      ),
    );
  }
}
