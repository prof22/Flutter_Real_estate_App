import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/bloc/properties_bloc.dart';
import 'review.dart';
import '../controller/properties_provider.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/screen/property_detail.dart';
import 'dart:math' as math;

import 'package:real_estate_app/services/rating_service.dart';

class HomeFeaturedProperties extends StatefulWidget {
  // final List<Properties> propertiesList;
  // HomeFeaturedProperties({this.propertiesList});
  @override
  _HomeFeaturedPropertiesState createState() => _HomeFeaturedPropertiesState();
}

class _HomeFeaturedPropertiesState extends State<HomeFeaturedProperties> {
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
     final featuredProperties = Provider.of<PropertiesProvider>(context).featuredPropertiesList;
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: featuredProperties.length,
        itemBuilder: (context, index) {
           final badge = featuredProperties[index].badge;
            final ratingss = featuredProperties[index].rating;
          return InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetail(this.propertyTitle, this.widget.propertyImage, this.widget.propertyPrice, this.widget.propertyPurpose, this.widget.propertyType)));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PropertyDetail(
                          propertyId: featuredProperties[index].id,
                          propertyTitle: featuredProperties[index].title,
                          propertySlug: featuredProperties[index].slug,
                          propertyImage: featuredProperties[index].image,
                          propertyPrice: featuredProperties[index].price,
                          propertyPurpose:
                              featuredProperties[index].purpose,
                          propertyType: featuredProperties[index].type,
                          propertyDescription:
                              featuredProperties[index].description,
                          propertyAddress: featuredProperties[index].address,
                          propertyBathroom: featuredProperties[index].bathroom,
                          propertyBedroom: featuredProperties[index].bedroom,
                          propertyCity: featuredProperties[index].city,
                          propertyArea: featuredProperties[index].area,
                        agentId: featuredProperties[index].agentId,
                        nearBy: featuredProperties[index].nearBy,
                              )));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 5.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          image: DecorationImage(
                              image: 
                              NetworkImage(
                                featuredProperties[index].image),
                              fit: BoxFit.cover)),
                    ),
             

                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 5.6,
                      color: Theme.of(context).primaryColor.withOpacity(.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: <Widget>[
                                Expanded(
                      child: Padding(
                            padding: const EdgeInsets.only(left:16.0, top: 5.0),
                            child: Text(
                              '${featuredProperties[index].title}', 
                              style: TextStyle(color:Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                               overflow:TextOverflow.ellipsis
                            ),
                            
                          ),
                                ),
                          Expanded(
                           child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, right:10.0),
                              child: Text(
                               '\$${featuredProperties[index].price}', style: TextStyle(color:Colors.red),
                                overflow:TextOverflow.ellipsis
                                ),
                                  
                              ),
                          ),
                             ],
                           ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                            child: Row(
                               children: <Widget>[
                                Icon(Icons.hot_tub),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right:10.0),
                                  child: Text(
                                      '${featuredProperties[index].bathroom}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Icon(Icons.airline_seat_flat),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right:10.0),
                                  child: Text(
                                      '${featuredProperties[index].bedroom}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Icon(Icons.home),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                      '${featuredProperties[index].area} Sq.ft'),
                                )
                              ],
                            ),
                          ), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Expanded(
                                                                  child: Padding(
                            padding: const EdgeInsets.only(left:10.0, top: 5.0),
                            child: Text(
                              '${featuredProperties[index].address}, ${featuredProperties[index].city}', style: TextStyle(color:Colors.black),  overflow:TextOverflow.ellipsis),
                            ),
                                ),
                          
                          
                            ],
                          ),
                       Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                review(5, ratingss == null ? 0 : ratingss),  
                                Transform.rotate(angle: - math.pi / 9, child: Container(
                                  color: badge == 1 ? Colors.green:Colors.red,
                                 margin: EdgeInsets.all(5.0),
                                  child: Text( badge == 1 ?"Verified":"Unverified", style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0
                                  ),)),),
                              ],
                            )
                            //  SizedBox()
                        ],
                      ),
                    ),

                    //  Html(data:featuredProperties[index].description),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
