// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/models/comment.dart';
import 'package:real_estate_app/screen/home_screen.dart';
import 'package:real_estate_app/screen/login_screen.dart';
import 'package:real_estate_app/services/comment_count_services.dart';
import 'package:real_estate_app/services/logout_service.dart';
import 'package:real_estate_app/users/widget/drawers.dart';
import 'package:shared_preferences/shared_preferences.dart';





class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Comments> _commentsList = List<Comments>();

  bool islogin = false;
  var name, authToken, commentCounts;


  @override
  void initState() {
    super.initState();
    this.commentCount();
    this.comments();
    _fetchAndRedirect(context);
  }

  @override
  void dispose() {
   this.commentCount();
    _fetchAndRedirect(context);
    this.comments();
    super.dispose();
  }
  
  

 logout(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      // var tokens = prefs.getString('token');
       prefs.remove("token");
    var logoutService = LogOutService();
    await logoutService.logout(authToken);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
  
void  _fetchAndRedirect(BuildContext context) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(mounted){
      setState(() {
      name = prefs.getString('name');
     authToken = prefs.getString('token');
      });
      }    
     print('Name from login screen is $name');
     print('Token from login screen is $authToken');
     print(authToken);
     if(authToken == null)
     {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
     }else{
       if(mounted){
       setState(() {
          islogin = true;
       });
     }
     }
}
 
Future<dynamic> commentCount() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
      name = prefs.getString('name');
     authToken = prefs.getString('token');  
   var commentCount = CommentCountService();
    var  response = await commentCount.countComment(authToken);
    var result = json.decode(response.body);
    if(mounted){
      setState(() {
        commentCounts = result['commentCount'];
      });
    }
    
  }

  Future<dynamic> comments() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
      name = prefs.getString('name');
     authToken = prefs.getString('token');  
   var comment = CommentCountService();
    var  response = await comment.comment(authToken);
    var result = json.decode(response.body);
     result['data'].forEach((data) {
        var model = Comments();
        model.id = data['id'];
        model.body = data['body'];
    if(mounted){
      setState(() {
        _commentsList.add(model);
      });
    }
     });
    
  }
    @override
  Widget build(BuildContext context) {
       return Scaffold(
        appBar: AppBar(
          title: Text("User Dashboard", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
             ),),
           actions: <Widget>[
            InkWell(
              onTap: (){
                logout(context);
              },
              child: Icon(Icons.lock)),
            ],
            centerTitle: true,
        ),
          drawer: DrawerWidget(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:16.0, left:16.0, right:16.0),
                child: Row(
                children: <Widget>[
                 Container(
                   padding: EdgeInsets.only(top:15.0),
                   alignment: Alignment.topCenter,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     color: Theme.of(context).primaryColor,
                   ),
                   margin: EdgeInsets.all(5.0),
                   height: 100.0,
                  width:MediaQuery.of(context).size.width/2.4,
                     child: Column(
                       children: <Widget>[
                         Text('COMMENT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                         SizedBox(height: 10.0,),
                         Icon(Icons.comment, size: 35.0,color: Colors.white,),
                         Text('$commentCounts', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                       ],
                     ) 
                    ),
                    Container(
                   padding: EdgeInsets.only(top:15.0),
                   alignment: Alignment.topCenter,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     color: Theme.of(context).primaryColor,
                   ),
                   margin: EdgeInsets.all(5.0),
                   height: 100.0,
                  width:MediaQuery.of(context).size.width/2.4,
                     child: Column(
                       children: <Widget>[
                         Text('MESSAGES', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                         SizedBox(height: 10.0,),
                         Icon(Icons.message, size: 35.0,color: Colors.white,),
                         Text('1', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                       ],
                     ) 
                    ),
                   
                      ],
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0, right:16.0),
                child: Container(
                     padding: EdgeInsets.only(left:15.0),
                     alignment: Alignment.topCenter,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10.0),
                       color: Theme.of(context).primaryColor,
                     ),
                     margin: EdgeInsets.only(left:5.0, right:10.0),
                     height: 70.0,
                    width:MediaQuery.of(context).size.width,
                       child: Column(
                         children: <Widget>[
                           Text('RECENT COMMENT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                           SizedBox(height: 10.0,),
                           Icon(Icons.comment, size: 35.0,color: Colors.white,),
                         ],
                       ) 
                      ),
              ),
              Padding(padding: const EdgeInsets.only(top:16.0, left:16.0, right:16.0),
              child: Text("All Recent Comments"),
              ),
              Container(
                margin: EdgeInsets.only(left:5.0),
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0, left:16.0, right:16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(this._commentsList.length, (i) {
                      return Row(
                        children: <Widget>[
                          Text('${this._commentsList[i].id}'),
                          SizedBox(width:10.0),
                          Text('${this._commentsList[i].body}'),
                        ],
                      );
                    }
                    )),
                ),
              )
            ],
          )
          
          
          
          ));
    }

    

}
