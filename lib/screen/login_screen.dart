import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/services/login_service.dart';
import 'package:real_estate_app/services/register_service.dart';
// import 'package:real_estate_app/users/profile_screen.dart';
import 'package:real_estate_app/users/user_dashboard.dart';
import 'package:real_estate_app/widget/header.dart';
// import 'package:real_estate_app/widget/showDialog_redirect_to_admin.dart';
import 'package:real_estate_app/widget/show_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtPasswordConfirmation = TextEditingController();
  final txtName = TextEditingController();
  bool register = false;
  bool registerMessage = false;
  bool islogin = false;
  bool isloading = false;
  var authToken, name, message;
  String roleId = '3'; 
  String userApproval;
  String getUserApproval;
  int approval;

  @override
  void initState() { 
    super.initState();
    _fetchAndRedirect();
  }
  @override
  void dispose() { 
    _fetchAndRedirect();
    super.dispose();
  }

 void  _fetchAndRedirect() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(mounted){
      setState(() {
      name = prefs.getString('name');
      authToken = prefs.getString('token');
        getUserApproval = prefs.getString('userApproval');
      });
      }
    if (getUserApproval ==  'user approved' && authToken != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  DashboardScreen()));
}
   
 }

void loginUser(BuildContext context) async {
    Map data = {
      'email': txtEmail.text,
      'password': txtPassword.text,
    };
    var loginUser = LoginService();
    var response = await loginUser.login(data);
    if(response.statusCode == 401){
       showdialog(
            context, "Email/Password", "Email not found or Password is incorrect",
            );  
             if(mounted)
            {
              setState(() {
                txtEmail.clear();
                txtPassword.clear();
              });
            }
    }else if (response.statusCode == 200) {
      var jsonbody = json.decode(response.body);
      if(mounted){
        setState(() {
          message = jsonbody['message'];
          userApproval = 'user approved';
          approval = jsonbody['user']['approval'];
          isloading = false;
        });
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonbody['access_token']);
      prefs.setInt('user_id', jsonbody['user_id']);
      prefs.setString('userApproval', userApproval);
      prefs.setInt('approval', approval);
      if(message == userApproval){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
      
      
    }
 }

  registerNewUser() async {
    if(txtPassword.text == txtPasswordConfirmation.text){
    Map data = {
      'name': txtName.text,
      'email': txtEmail.text,
      'password': txtPassword.text,
      'password_confirmation':txtPasswordConfirmation.text,
      'role_id':  roleId, // thats 3 for user
      'approval': '1'
    };
    var loginUser = RegisterService();
    var response = await loginUser.registerNewUser(data);
    if(response.statusCode == 302){
      showdialog(
            context, "Email", "Email Already Exist",
            );  
            if(mounted)
            {
              setState(() {
                txtEmail.clear();
              });
            }
    }
    else if (response.statusCode == 200) {
       showdialog(
       context, "Registration", "Your Registration is Successful, \n Login to Your Dashboard",
      );
      setState(() {
        txtEmail.clear();
        txtName.clear();
        txtPassword.clear();
        registerMessage = true;
        register = false;
      });
    }
    }else{
      showdialog(
       context, "Password", "Password Did not Match",
      );
      if(mounted)
      {
        setState(() {
          txtPassword.clear();
          txtPasswordConfirmation.clear();
        });
      }
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          isAppTitle: false,
          titleText: !register ? "Login To Your Account" : "Create An Account"),
      body: ListView(
        children: <Widget>[
          Center(
            heightFactor: 2.0,
            child: Icon(
              Icons.account_balance,
              size: 50.0,
            ),
          ),
          !register ? loginScreen() : registerScreen(),
        ],
      ),
    );
  }

  Center loginScreen() {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: 250.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              TextField(
                controller: txtEmail,
                  keyboardType:TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email Address", prefixIcon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: txtPassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", prefixIcon: Icon(Icons.lock)),
              ),
              Container(
                width: 250.0,
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                          isloading = true;
                      });
                      loginUser(context);
                    },
                    child: isloading?CircularProgressIndicator():Text("Login")),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Don\'t have Account?"),
              SizedBox(
                height: 20.0,
              ),
              Icon(Icons.arrow_downward),
              InkWell(
                onTap: () {
                  setState(() {
                    register = true;
                  });
                },
                child: Text(
                  'Create An Account',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          )),
    );
  }

 Center registerScreen() {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: 250.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              TextField(
                controller: txtName,
                decoration: InputDecoration(
                    hintText: "Enter Name", prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                 keyboardType:TextInputType.emailAddress,
                controller: txtEmail,
                decoration: InputDecoration(
                    hintText: "Email Address", prefixIcon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: txtPassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", prefixIcon: Icon(Icons.lock)),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: txtPasswordConfirmation,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password", prefixIcon: Icon(Icons.lock)),
              ),
           
              SizedBox(height:20.0),
              Container(
                width: 250.0,
                margin: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      registerNewUser();
                    },
                    child: Text("Create An Account")),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Have An Account?"),
              SizedBox(
                height: 20.0,
              ),
              Icon(Icons.arrow_downward),
              InkWell(
                onTap: () {
                  setState(() {
                    register = false;
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          )),
    );
  }

}