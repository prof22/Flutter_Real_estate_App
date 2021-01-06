import 'package:flutter/material.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/screen/property_detail.dart';
import 'dart:math' as math;

class RelatedProperties extends StatefulWidget {
  final List<Properties> propertiesList;
  RelatedProperties({this.propertiesList});
  @override
  _RelatedPropertiesState createState() => _RelatedPropertiesState();
}

class _RelatedPropertiesState extends State<RelatedProperties> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.propertiesList==null ? 1 : this.widget.propertiesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetail(this.propertyTitle, this.widget.propertyImage, this.widget.propertyPrice, this.widget.propertyPurpose, this.widget.propertyType)));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PropertyDetail(
                          propertyId: this.widget.propertiesList[index].id,
                          propertyTitle: this.widget.propertiesList[index].title,
                          propertySlug: this.widget.propertiesList[index].slug,
                          propertyImage: this.widget.propertiesList[index].image,
                          propertyPrice: this.widget.propertiesList[index].price,
                          propertyPurpose:
                              this.widget.propertiesList[index].purpose,
                          propertyType: this.widget.propertiesList[index].type,
                          propertyDescription:
                              this.widget.propertiesList[index].description,
                          propertyAddress: this.widget.propertiesList[index].address,
                          propertyBathroom: this.widget.propertiesList[index].bathroom,
                          propertyBedroom: this.widget.propertiesList[index].bedroom,
                          propertyCity: this.widget.propertiesList[index].city,
                          propertyArea: this.widget.propertiesList[index].area,
                        agentId: this.widget.propertiesList[index].agentId,
                        nearBy: this.widget.propertiesList[index].nearBy,
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
                             this.widget.propertiesList==null ? 0: widget.propertiesList[index].image.toString()),
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
                              '${this.widget.propertiesList[index].title}', 
                              style: TextStyle(color:Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                               overflow:TextOverflow.ellipsis
                            ),
                            
                          ),
                                ),
                          Expanded(
                           child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, right:10.0),
                              child: Text(
                               '\$${this.widget.propertiesList[index].price}', style: TextStyle(color:Colors.red),
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
                                      '${this.widget.propertiesList[index].bathroom}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Icon(Icons.airline_seat_flat),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right:10.0),
                                  child: Text(
                                      '${this.widget.propertiesList[index].bedroom}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Icon(Icons.home),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                      '${this.widget.propertiesList[index].area} Sq.ft'),
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
                              '${this.widget.propertiesList[index].address}, ${this.widget.propertiesList[index].city}', style: TextStyle(color:Colors.black),  overflow:TextOverflow.ellipsis),
                            ),
                                ),
                          
                          
                            ],
                          ),
                       this.widget.propertiesList[index].badge == 1? Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Transform.rotate(angle: - math.pi / 9, child: Container(
                                  color: Colors.green,
                                 margin: EdgeInsets.all(5.0),
                                  child: Text("Verified", style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0
                                  ),)),),
                              ],
                            ):
                            Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Transform.rotate(angle: - math.pi / 9, child: Container(
                                  color: Colors.red,
                                 margin: EdgeInsets.all(5.0),
                                  child: Text("Unverified", style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 15.0
                                  ),)),),
                              ],
                            )
                            //  SizedBox()
                        ],
                      ),
                    ),

                    //  Html(data:this.widget.propertiesList[index].description),
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
