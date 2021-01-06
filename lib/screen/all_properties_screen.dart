import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/bloc/properties_bloc.dart';
import 'package:real_estate_app/controller/allProperties_provider.dart';
import 'package:real_estate_app/controller/properties_provider.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/screen/property_detail.dart';
import 'package:real_estate_app/services/rating_service.dart';
import 'package:real_estate_app/widget/header.dart';
import '../widget/review.dart';

class HomeAllProperties extends StatefulWidget {
  @override
  _HomeAllPropertiesState createState() => _HomeAllPropertiesState();
}

class _HomeAllPropertiesState extends State<HomeAllProperties> {
   var rating = 3.0;
  @override
  void initState() { 
    getRating();
    super.initState();
  }
  @override
  void dispose() {
    getRating();
    super.dispose();
  }

   getRating() async{
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
  @override
  Widget build(BuildContext context) {
        final allProperties = Provider.of<PropertiesProvider>(context).allPropertyList;
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: "All Properpties"),
      body: OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          crossAxisSpacing: 2.0,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: List.generate(allProperties.length,
            (i) {
            final x = allProperties[i];
            final ratingss = x.rating;
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertyDetail(
                              propertyId: x.id,
                              propertyTitle: x.title,
                              propertySlug:x.slug,
                              propertyImage: x.image,
                              propertyPrice: x.price,
                              propertyPurpose: x.purpose,
                              propertyType: x.type,
                              propertyDescription: x.description,
                              propertyCity: x.city,
                              propertyAddress: x.address,
                              propertyBathroom: x.bathroom,
                              propertyBedroom: x.bedroom,
                              propertyArea: x.area,
                              agentId: x.agentId,
                              nearBy: x.nearBy,
                            )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Container(
                      margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 4.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image:
                                  NetworkImage(x.image),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Card(
                    elevation: 8.0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Theme.of(context).primaryColor.withOpacity(.5),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'N${x.price}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('${x.city}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                review(5, ratingss == null ? 0 : ratingss),      
                                 ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.airline_seat_flat),
                                    Text('${x.bedroom}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.home),
                                    Text('${x.area} sq.ft',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }));       
      }),
    );
  }
}
