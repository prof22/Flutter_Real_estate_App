import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/controller/properties_provider.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/screen/property_detail.dart';
import 'package:real_estate_app/services/rating_service.dart';
import 'package:real_estate_app/widget/review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HomeProperties extends StatefulWidget {
  @override
  _HomePropertiesState createState() => _HomePropertiesState();
}

class _HomePropertiesState extends State<HomeProperties> {

var rating = 3.0;
 @override
  void initState() {
    getRatings();
    super.initState();
    
  }
    @override
  void dispose() {
   getRatings();
       
    super.dispose();
  }

 getRatings() async{
    var getRating = RatingService();
    var response = await getRating.getRating();
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
     final frontProperties = Provider.of<PropertiesProvider>(context).allFrontPropertyList;
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          crossAxisSpacing: 2.0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(frontProperties.length,
            (i) {
            final x = frontProperties[i];
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
    });
  }


}


