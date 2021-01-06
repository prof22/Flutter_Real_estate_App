import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/controller/properties_provider.dart';
import 'package:real_estate_app/screen/property_by_city.dart';

class HomePropertyImage extends StatefulWidget {
  @override
  _HomePropertyImageState createState() => _HomePropertyImageState();
}

class _HomePropertyImageState extends State<HomePropertyImage> {  
  @override
  Widget build(BuildContext context) {
    final imageProperties = Provider.of<PropertiesProvider>(context).propertyImageList;
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          crossAxisSpacing: 2.0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(imageProperties.length, (i) {
            final x = imageProperties[i];
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertiesByCity(
                                  propertyCity: x.city,
                                )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0)),
                        image: DecorationImage(
                            image: NetworkImage(x.image),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 99.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(top: 12.0),
                              width: MediaQuery.of(context).size.width,
                              height: 40.0,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.5),
                              child: Text(
                                '${x.city}',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }));
    });
  }
}
