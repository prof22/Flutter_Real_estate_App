import 'package:flutter/material.dart';
import 'package:real_estate_app/screen/all_properties_screen.dart';
import 'package:real_estate_app/widget/Home_property_image.dart';
import 'package:real_estate_app/widget/home_featured_properties.dart';
import 'package:real_estate_app/widget/home_properties.dart';


class Timeline extends StatefulWidget {
 
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Colors.transparent),
    );
    return SafeArea(
      child: Container(
            height: MediaQuery.of(context).size.height,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(300.0, 50.0),
                    bottomLeft: Radius.elliptical(300.0, 50.0)),
                color: Theme.of(context).primaryColor.withOpacity(.5)),
          ),
          Positioned(
            bottom: 50.0,
            right: 150.0,
            child: Container(
              width: 400.0,
              height: 400.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  color: Theme.of(context).primaryColor.withOpacity(.5)),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 150.0,
            child: Container(
              width: 400.0,
              height: 400.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  color: Theme.of(context).primaryColor.withOpacity(.5)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0),
                child: Text(
                  "Find Your\n Dream Home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: Material(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.search, color: Colors.grey[400]),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16.0),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        hintText: "Try Search Location"),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Featured Properties',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeAllProperties()));
                          },
                          child: Text('See All',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0))),
                    ],
                  )),
                   HomeFeaturedProperties(),
            ],
          )
        ],
      ),
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Popular Near You',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeAllProperties()));
                  },
                  child: Text('See All',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0))),
            ],
          )),
      SizedBox(height: 20.0),
      HomePropertyImage(),
   

      SizedBox(height:20.0),
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Recent Properties',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeAllProperties()));
                  },
                  child: Text('See All',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0))),
            ],
          )),
      SizedBox(height: 20.0),
      HomeProperties(),
 
            ],
          ),
        ),
    );
  }
}
