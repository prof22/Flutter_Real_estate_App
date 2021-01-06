import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate_app/services/slider_service.dart';
import 'package:real_estate_app/widget/carousel_slider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SliderService _sliderService = SliderService();
  var imageUrl = "http://192.168.8.100:8000/storage/slider/";

  var items = [];

    @override
  void initState() { 
    super.initState();
    _getAllSliders();
  }
  _getAllSliders() async{
    var sliders = await _sliderService.getSliders();
    var result = json.decode(sliders.body);
    result['data'].forEach((data){
      if(mounted){
      setState(() {
        items.add(NetworkImage(imageUrl +data['image']));
      });}
    });
    print(result); 
  
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Real Estate..')
      ),
      body: Container(
        child:ListView(
          children:<Widget>[
            carouselSlider(items)
          ]
        )
      ),
    );
  }
}