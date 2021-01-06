import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/carousel_slider.dart';

class NewTimeline extends StatefulWidget {
  @override
  _NewTimelineState createState() => _NewTimelineState();
}

class _NewTimelineState extends State<NewTimeline> {
  List items = [
    AssetImage('assets/images/slider1.jpg'),
    AssetImage('assets/images/slider2.jpg'),
    AssetImage('assets/images/slider3.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            carouselSlider(items)
          ]
          
          ,),),
    );
  }
}