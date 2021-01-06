import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/models/comment.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/screen/login_screen.dart';
import 'package:real_estate_app/services/comment_count_services.dart';
import 'package:real_estate_app/services/post_comment_service.dart';
import 'package:real_estate_app/services/properties_service.dart';
import 'package:real_estate_app/services/rating_service.dart';
import 'package:real_estate_app/widget/Home_property_image.dart';
import 'package:real_estate_app/widget/related_Properties.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AgentDetail extends StatefulWidget {
  final int agentId;
  final String propertyImage;
  final int propertyId;
  final String agentName;
  final String agentEmail;
  final String propertySlug;
  final double propertyRating;
  final String agentCity;
  final String agentPhone;
  final String agentState;
  final String agentCountry;
  final String agentAbout;
  AgentDetail(
      {this.agentId,
      this.propertyImage,
      this.propertyId,
      this.agentName,
      this.agentEmail, 
      this.propertySlug,
      this.propertyRating,
      this.agentCity,
      this.agentCountry,
      this.agentPhone,
      this.agentState,
      this.agentAbout
      
      });

  @override
  _AgentDetailState createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  PropertiesService _propertiesService = PropertiesService();

  // var imageUrl = "http://192.168.8.101:8000/storage/property/";

  List<Properties> _propertiesList = List<Properties>();
    List<Comments> _commentLists = List<Comments>();
    bool loaded = false;
    bool islogin = false;
     final txtbody = TextEditingController();
     var rating;
     var ratings = 0.0;

  var authToken;
  //get Token
  void _fetchAndRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        authToken = prefs.getString('token');
        print('The Token set is  $authToken');
      });
    }
    if (authToken != null) {
      if (mounted) {
        setState(() {
          islogin = true;
        });
      }
    }
  }
      getRatings() async{
    var getRating = RatingService();
    var response = await getRating.getRating();
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result['data'].forEach((data) {
       data['rating'].forEach((rating){
        if(mounted){
        setState(() {
          rating = double.parse(rating['rating']);
          print(rating);       
        });
        }
       });
        
      });
    }

  } 
  sendRating(v) async
  {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var userId = prefs.getInt('user_id');
    Map data = {
      'user_id': userId.toString(),
      'property_id': this.widget.propertyId.toString(),
      'rating': v.toString()
    };
    var getRating = RatingService();
    var response = await getRating.sendRating(authToken, data);
    print(response.statusCode);
    if (response.statusCode == 200) {
        print('success');
    }
    
  }
  @override
  void initState() {
    _fetchAndRedirect();
     _getAllRelatedProperties();
    getComment();
    getRatings();
    super.initState();
  }
 
  @override
  void dispose() {
    _fetchAndRedirect();
     _getAllRelatedProperties();
    getComment();
    getRatings();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agent Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
           controller: ScrollController(),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(this.widget.propertyImage),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Mr. ${this.widget.agentName}'),
                            Text('${this.widget.agentEmail}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                              Text('Flat Agent |'),
                              Text(' Developer'),

                            ],),
                            SizedBox(height: 20.0,),
                               Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                              Text('Call |'),
                              Text(' Message'),

                            ],), 

                          ]),
                          SizedBox(height: 20.0,),
                    ],
                  )
                ]),
              ),
              _propertiesList.isEmpty? SizedBox():
              Text('Related Property'),
              _propertiesList.isEmpty? SizedBox(): RelatedProperties(
                            propertiesList: _propertiesList,
                          ),
              _propertiesList.isEmpty? SizedBox():Text('City List'),
             _propertiesList.isEmpty? SizedBox(): SizedBox(height: 20.0),
             _propertiesList.isEmpty? SizedBox(): HomePropertyImage(),
              Divider(),
             islogin
                      ?  SmoothStarRating(
                              allowHalfRating: false,
                              starCount: 5,
                              rating: ratings,
                                onRated: (v) {
                                  sendRating(v);
                                },
                              color: Colors.green,
                              borderColor: Colors.green,
                              spacing: 0.0,
                            ):SizedBox(),
              Divider(),
               islogin
                      ? commentSection()
                      : Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text('Login to Comment', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),)),
                        ),
              
                Divider(),
              Text('Review'),
              displayComment(),
                Divider()
            ],
          ),
        ),
    );
  }
   Container displayComment()
  {
    return Container(
      height: MediaQuery.of(context).size.height,
      child:Column(
          children:List.generate(_commentLists.length, (i) {
          return Container(
            child:Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               CircleAvatar(
                backgroundImage:
                    NetworkImage(_commentLists[i].image),
                  
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0, right:8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Text('${_commentLists[i].userName}', style: TextStyle(color: Colors.grey[600])),
                    Text('${_commentLists[i].body}'),
                 
                  ],
                ),
              )
            ],
          ),
        ),
        
      ],
            )
          );
          }
        )
        )
    );

  }
Container commentSection() {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    );
    return Container(
      margin: EdgeInsets.all(16.0),
      //  height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Text('Leave a comment'),
          SizedBox(height: 16.0),
          TextField(
            controller: txtbody,
            autocorrect: true,
            decoration: InputDecoration(
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                hintText: "Drop a Comment"),
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColor,
            ),
            child: FlatButton(
                onPressed: () {
                  sendComment();
                },
                child: Text('Comment')),
          ),
        ],
      ),
    );
  }

 sendComment() async{
    Map data = {
      'body': txtbody.text,
    };
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var postComment = PostCommentService();
    var response = await postComment.postComment(authToken, this.widget.propertyId, data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result['message']);
    }
  }
  
  _getAllRelatedProperties() async {
    var responseJson = await _propertiesService.getRelatedProperty(this.widget.propertySlug);
    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
      // var result = json.decode(responseJson.body);
      // print(result);
    } else {
         var result = json.decode(responseJson.body);
      print(result);
      result['data'].forEach((data) {
        var model = Properties();
        model.id = data['id'];
        model.title = data['title'];
        model.price = data['price'];
        model.purpose = data['purpose'];
        model.type = data['type'];
        model.image = Imgurl.imageUrl + data['image'];
        model.bedroom = data['bedroom'];
        model.bathroom = data['bathroom'];
        model.address = data['address'];
        model.city = data['city'];
        model.area = data['area'];
        model.slug = data['slug'];
        model.description = data['description'];
        model.floorPlan = data['floor_plan'];
        model.nearBy = data['nearby'];
        model.agentId = data['agent_id'];
        print(Imgurl.imageUrl + data['image']);
        if (mounted) {
          setState(() {
            _propertiesList.add(model);
          });
        }
      });
    }
  }
  getComment() async{
    var getComment = CommentCountService();
    var response = await getComment.getComments(this.widget.propertySlug);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      result['users'].forEach((user) {
        var model = Comments();
        model.id = user['id'];
        model.body = user['body'];
        model.userName = user['users']['name'];
        model.image = Imgurl.usersUrl + user['users']['image'];
        print(Imgurl.usersUrl + user['users']['image']);
        if(mounted){
        setState(() {
          _commentLists.add(model);
        });
        }
      });
    }

  }
}

