import 'package:flutter/material.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/screen/property_detail.dart';
import 'package:real_estate_app/widget/header.dart';

class ResultScreen extends StatefulWidget {
  final List<Properties> propertiesList;
  
  ResultScreen({this.propertiesList});
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {




  @override
  void initState() {
    super.initState();

  }
@override
  void dispose() {
    super.dispose();
  
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: "Search Result"),
      body: OrientationBuilder(builder: (context, orientation) {
        return ListView(
            controller: ScrollController(),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            // physics: NeverScrollableScrollPhysics(),
            children: List.generate(this.widget.propertiesList.length, (i) {
              // final x = this.widget.propertiesList[i];
              return InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetail(this.propertyTitle, this.widget.propertyImage, this.widget.propertyPrice, this.widget.propertyPurpose, this.widget.propertyType)));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PropertyDetail(
                                propertyId: this.widget.propertiesList[i].id,
                                propertyTitle: this.widget.propertiesList[i].title,
                                propertySlug:this.widget.propertiesList[1].slug,
                                propertyImage: this.widget.propertiesList[i].image,
                                propertyPrice: this.widget.propertiesList[i].price,
                                propertyPurpose: this.widget.propertiesList[i].purpose,
                                propertyType: this.widget.propertiesList[i].type,
                                propertyDescription: this.widget.propertiesList[i].description,
                                propertyCity: this.widget.propertiesList[i].city,
                                propertyAddress: this.widget.propertiesList[i].address,
                                agentId: this.widget.propertiesList[i].agentId,
                              )));
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
                                image: NetworkImage(
                                    widget.propertiesList[i].image),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width / 3.6,
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
                                    Text('N${this.widget.propertiesList[i].price}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      '${this.widget.propertiesList[i].city}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                      child: Text(
                                          '${this.widget.propertiesList[i].address} andggd etheydhh tehyd teheyd hhe',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),

                                  //  Icon(Icons.home),
                                  //  Text('${this.widget.propertiesList[i].area} Sq.ft')
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
                                      Text('${this.widget.propertiesList[i].bathroom}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.airline_seat_flat),
                                      Text('${this.widget.propertiesList[i].bedroom}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.home),
                                      Text('${this.widget.propertiesList[i].area} sq.ft',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
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
