
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/bloc/properties_bloc.dart';
import 'package:real_estate_app/controller/agent_detail_provider.dart';
import 'package:real_estate_app/controller/properties_provider.dart';
import 'package:real_estate_app/models/agent.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/screen/agent_details.dart';
import 'package:real_estate_app/services/get_agent_service.dart';
import 'package:real_estate_app/services/post_comment_service.dart';
import 'package:real_estate_app/services/property_gallery_service.dart';
import 'package:real_estate_app/widget/carousel_slider.dart';
import 'package:real_estate_app/widget/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PropertyDetail extends StatefulWidget {
  final int propertyId;
  final String propertyTitle;
  final String propertySlug;
  final String propertyImage;
  final int propertyPrice;
  final String propertyType;
  final String propertyPurpose;
  final String propertyDescription;
  final String propertyCity;
  final String propertyAddress;
  final int propertyBedroom;
  final int propertyBathroom;
  final int propertyArea;
  final int agentId;
  final String nearBy;
  final double rating;
  PropertyDetail(
      {this.propertyId,
      this.propertyTitle,
      this.propertySlug,
      this.propertyImage,
      this.propertyPrice,
      this.propertyPurpose,
      this.propertyType,
      this.propertyDescription,
      this.propertyCity,
      this.propertyAddress,
      this.propertyBedroom,
      this.propertyBathroom,
      this.propertyArea,
      this.agentId,
      this.nearBy,
      this.rating});
  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  PropertyGalleryService _propertyGalleryService = PropertyGalleryService();
    GetAgentService _agentService = GetAgentService();

  List<Agent> _agentList = List<Agent>();
  
  final txtbody = TextEditingController();
  bool _loading = true;
   var items = [];
   var displayImageId = [];
  var displayImage = [];
  bool islogin = false;
  String agentNumber = "Call Agent";
  String agentChat = "Chat Agent";

  var authToken;
  //get Token
  void _fetchAndRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        authToken = prefs.getString('token');
        // print('The Token set is  $authToken');
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

 _getAllSliders() async {
    var responseJson = await _propertyGalleryService
        .getPropertiesGallery(this.widget.propertyId);
    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
      // var result = json.decode(responseJson.body);
      // print(result);
      if (mounted) {
        setState(() {
          _loading = true;
        });
      }
    } else {
      responseJson['data'].forEach((data) {
        //  print(imgUrl.sliderImgUrl + data['name']);
        if (mounted) {
          setState(() {
            items.add(NetworkImage(Imgurl.sliderImgUrl + data['name']));
            displayImageId.add(data['id']);
            displayImage.add(Imgurl.sliderImgUrl + data['name']);

            _loading = false;
          });
        }
      });
    }
  }


  void initState() {
      _fetchAndRedirect();
    _getAgentDetails();
    _getAllSliders();
    //  Future.microtask(()=>{
      // BlocProvider.getBloc<PropertySliderBloc>().getAllSliders(this.widget.propertyId);
    // });
    super.initState();

    
  }
  @override
  void dispose() {
    _fetchAndRedirect();
    _getAgentDetails();
    _getAllSliders();
    BlocProvider.disposeBloc<PropertySliderBloc>();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     Provider.of<AgentDetailsProvider>(context).setAgentDetails(this.widget.propertyId);
  }

  sendComment() async{
    Map data = {
      'body': txtbody.text,
    };
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var postComment = PostCommentService();
    var response = await postComment.postComment(authToken, this.widget.propertyId, data);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      json.decode(response.body);
      // print(result['message']);
    }
  }
  



  @override
  Widget build(BuildContext context) {
      final loadedDetail = Provider.of<PropertiesProvider>(context)
      .findByid(this.widget.propertyId);
     
    return Scaffold(
      // drawer: islogin?drawerWidget(context):null,
      appBar: header(context,
          isAppTitle: false, titleText: loadedDetail.title),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              scrollDirection: Axis.vertical,
                controller: ScrollController(),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
           carouselSlider(items),              
             
                     

                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                              Expanded(
                                child: Text(
                                      loadedDetail.title, 
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor, 
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                 child: Padding(
                                   padding: const EdgeInsets.only(left:80.0),
                                   child: Text(
                                       'N'+ loadedDetail.price.toString(),
                                         overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                          color: Colors.red, 
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                 ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                  child: Text(
                                      loadedDetail.address + ',' + loadedDetail.city,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.hot_tub),
                                        Text(
                                            loadedDetail.bathroom.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                                SizedBox(width: 15.0,),
                                        Icon(Icons.airline_seat_flat),
                                        Text(
                                            loadedDetail.bedroom.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                                 SizedBox(width: 15.0,),
                                        Icon(Icons.home),
                                        Text(
                                            loadedDetail.area.toString() + 'sq.ft',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                  Divider(color: Colors.grey,),
                               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Photo Gallery", style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
                ),
                Divider(color: Colors.grey,),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(this.displayImage[index].toString()),
          
          basePosition: Alignment.centerLeft,
          initialScale: PhotoViewComputedScale.contained * 1,
             minScale: PhotoViewComputedScale.contained * 0.8,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 8,
        );
      },
      itemCount: this.items.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          // width: 20.0,
          height: MediaQuery.of(context).size.height / 6.9,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
  // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        //   loadingChild: Center(
        //   child: CircularProgressIndicator(),
        // ),
    )
                //    ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         itemCount: this.items.length,
                //         itemBuilder: (context, index) {
                //           return Container(
                //             margin: EdgeInsets.all(5.0),
                //             width: MediaQuery.of(context).size.width / 2.9,
                //             //  height: MediaQuery.of(context).size.height / 2.9,
                //             decoration: BoxDecoration(
                //                 // borderRadius: BorderRadius.only(
                //                 //     topLeft: Radius.circular(20.0),
                //                 //     topRight: Radius.circular(20.0)),
                //                 borderRadius:BorderRadius.circular(20.0),
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                         this.displayImage[index].toString()),
                //                     fit: BoxFit.cover)),
                // );
                //         })
                        
                        ),




                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Property Description', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
                                  Container(
                                      height: 29.0,
                                      margin: EdgeInsets.all(4.8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgentDetail(
                                                            agentId: this
                                                                .widget
                                                                .agentId,
                                                            propertyImage: this
                                                                .widget
                                                                .propertyImage, propertyId:this.widget.propertyId,
                                                                propertySlug:this.widget.propertySlug, propertyRating: this.widget.rating,
                                                                agentCity:  _agentList.map((f) => f.city).toString(),
                                                                agentAbout: _agentList.map((f) => f.about).toString(),
                                                                agentCountry: _agentList.map((f) => f.country).toString(),
                                                                agentEmail: _agentList.map((f) => f.email).toString(),
                                                                agentName: _agentList.map((f) => f.name).toString(),
                                                                agentPhone: _agentList.map((f) => f.phone).toString(),
                                                                agentState: _agentList.map((f) => f.state).toString(),
                                                             )));
                                          },
                                          child: Text(
                                            'Contact Agent',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )))
                                ],
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: MediaQuery.of(context).size.width/2,
                                  // color: Colors.red,
                                  child: Container(
                                      // elevation: 5.0,
                                      child: Html(
                                        data: this.widget.propertyDescription,
                                        defaultTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                            customTextAlign: (_)=> TextAlign.justify,
                                      ))),
                              Divider(),
                            ],
                          ))
                      //  Text(this.widget.propertyCity),
                      // Html(data:this.widget.propertyDescription),
                    ],
                  ),
                ),
                  SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Text('NearBy', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
                ),
                 Divider(),
                 Padding(
                   padding: const EdgeInsets.only(left:5.0, right: 10.0),
                   child: Container(
                      padding: const EdgeInsets.only(left:10.0, right: 10.0),
                                    width: MediaQuery.of(context).size.width,
                                    // height: MediaQuery.of(context).size.width/2,
                                    // color: Colors.red,
                                    child: Container(
                                        // elevation: 5.0,
                                        child: Html(
                                          data: this.widget.nearBy,
                                          defaultTextStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                              customTextAlign: (_)=> TextAlign.justify,
                                        ))),
                 ),
                             
                Divider(),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Text('Contact Agent', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
                ),
              
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
           Container(
             margin: EdgeInsets.all(8.0),
             height: MediaQuery.of(context).size.height/ 2.0,
             child: Column(
                 children: List.generate(this._agentList.length, (i) {
               return Column(
                 children: <Widget>[
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    
                       children: <Widget>[
                         CircleAvatar(
                           backgroundImage:
                               NetworkImage(this.widget.propertyImage),
                         ),
                         SizedBox(width: 30.0,),
                       Flexible(
                              child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                               Text('Mr. ${this._agentList[i].name}'),
                                  SizedBox(height: 20.0,),
                               Text('${this._agentList[i].email}'),
                               SizedBox(height: 20.0,),
                               Wrap(
                                 children: <Widget>[
                                   Text('${this._agentList[i].address}',
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                   )
                                 ],
                               ),
                             SizedBox(height: 8.0,),
                             Text('${this._agentList[i].city}, ${this._agentList[i].state}, ${this._agentList[i].country}'),
                            
                                 SizedBox(height: 20.0,),
                               Text('Age: ${this._agentList[i].age}'),
                                    SizedBox(height: 20.0,),
                               Text('Height:${this._agentList[i].height} fts'),
                               SizedBox(height: 20.0,),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                   Container(
                                     height: 25.0,
                                     decoration: BoxDecoration(
                                       borderRadius:BorderRadius.circular(10.0),
                                        color: Colors.blue[900],
                                     ),
                                    
                                     child:InkWell(
                                      onTap: (){
                                     setState(() {
                                          islogin? agentNumber = this._agentList[i].phone: agentNumber = "Login to See Phone Number";
                                    
                                     });
                                        
                                      },
                                       child:Row(
                                         children: <Widget>[
                                           Icon(Icons.call, color: Colors.white),
                                           Text('$agentNumber', style: TextStyle( color: Colors.white),)
                                           
                                         ],
                                       )
                                       )
                                     ),
                                  //  ),
                                   Container(
                                     margin: EdgeInsets.all(5.0),
                                     height: 25.0,
                                     decoration: BoxDecoration(
                                       borderRadius:BorderRadius.circular(10.0),
                                        color: Colors.green[900],
                                     ),
                                    
                                     child: InkWell(
                                       onTap: (){
                                     setState(() {
                                          islogin? agentChat= this._agentList[i].email: agentChat= "Login to See Phone Email";
                                    
                                     });
                                       },
                                     child: Row(
                                       children: <Widget>[
                                         Icon(Icons.chat, color: Colors.white),
                                         Text('$agentChat', style: TextStyle( color: Colors.white),)
                                       ],
                                     )
                                     ),
                                   )
                                 ],
                               )
                           ],
                         ),
                       )
                       ],
                     ),
                  
                 Container(
                                   height: 25.0,
                                   width: 150.0,
                                   decoration: BoxDecoration(
                                     borderRadius:BorderRadius.circular(10.0),
                                      color: Colors.blue[900],
                                   ),
                                  
                                   child: FlatButton(onPressed: (){
                                      Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgentDetail(
                                                            agentId: this
                                                                .widget
                                                                .agentId,
                                                            propertyImage: this
                                                                .widget
                                                                .propertyImage, propertyId:this.widget.propertyId,
                                                                agentName: this._agentList[i].name,
                                                                agentEmail: this._agentList[i].email,
                                                                  propertySlug:this.widget.propertySlug,
                                                                  agentCity: this._agentList[i].city,
                                                                  agentCountry: this._agentList[i].country,
                                                                  agentState: this._agentList[i].state,
                                                                  agentPhone: this._agentList[i].phone,
                                                                  agentAbout: this._agentList[i].about,
                                                                )));
                                          
                                   }, 
                                   child: Text('More Details', style: TextStyle( color: Colors.white),)
                                   ),
                                 )
                 ],
               );}),
             ),
           ),

              ],
            ),
    );
  }
 _getAgentDetails() async {
    var responseJson = await _agentService.getAgentDetails(this.widget.agentId);

    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
  
    } else {
      responseJson['data'].forEach((data) {
        var model = Agent();
        model.id = data['id'];
        model.name = data['name'];
        model.username = data['username'];
        model.image = Imgurl.imageUrl + data['image'];
        model.email = data['email'];
        model.phone = data['phone'];
        model.sex = data['sex'];
        model.address = data['address'];
        model.height = data['height'];
        model.age = data['age'];
        model.city = data['city'];
        model.state = data['state'];
        model.country = data['country'];
        model.about = data['about'];
        if(mounted){
          setState(() {
            _agentList.add(model);
          });
        }
      });
    }
  }

  }
