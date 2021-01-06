import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/screen/property_detail.dart';
import 'package:real_estate_app/services/property_image_service.dart';
import 'package:real_estate_app/widget/header.dart';

class PropertiesByCity extends StatefulWidget {
  final String propertyCity;
  PropertiesByCity({
    this.propertyCity,
  });
  @override
  _PropertiesByCityState createState() => _PropertiesByCityState();
}

class _PropertiesByCityState extends State<PropertiesByCity> {
  PropertyImageService _propertyService = PropertyImageService();
  List<Properties> _propertiesList = List<Properties>();

  @override
  void initState() {
    _getPropertiesByCity();
    print(this.widget.propertyCity);
    super.initState();
  }

  @override
  void dispose() {
    _getPropertiesByCity();
    super.dispose();
  }

  _getPropertiesByCity() async {
    var responseJson =
        await _propertyService.allpropertyCity(this.widget.propertyCity);
    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
     
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
        model.badge = data['badge'];
        print(Imgurl.imageUrl + data['image']);
        if (mounted) {
          setState(() {
            _propertiesList.add(model);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: "Properpties by City"),
      body: OrientationBuilder(builder: (context, orientation) {
        return ListView(
            controller: ScrollController(),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            // physics: NeverScrollableScrollPhysics(),
            children: List.generate(_propertiesList.length, (i) {
              final x = _propertiesList[i];
              return InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetail(this.propertyTitle, this.widget.propertyImage, this.widget.propertyPrice, this.widget.propertyPurpose, this.widget.propertyType)));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PropertyDetail(
                              propertyId: x.id,
                              propertyTitle: x.title,
                              propertySlug: x.slug,
                              propertyImage: x.image,
                              propertyPrice: x.price,
                              propertyPurpose: x.purpose,
                              propertyType: x.type,
                              propertyDescription: x.description,
                              propertyCity: x.city,
                              propertyAddress: x.address,
                              agentId: x.agentId,
                              nearBy: x.nearBy,
                              rating: x.rating)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // margin: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 1.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(x.image),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width / 2.6,
                        margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                     Text('${x.title}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text('N${x.price}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                   
                                  ],
                                ),
                              ),

                              Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${x.address}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),

                                  //  Icon(Icons.home),
                                  //  Text('${x.area} Sq.ft')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.hot_tub),
                                      Text('${x.bathroom}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
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
                               Align(
                                 alignment: Alignment.center,
                                 heightFactor: 2.0,
                                                                child: Text(
                                        '${x.city}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                               ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
      }),
    );
  }
}
