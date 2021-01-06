import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';

Widget carouselSlider(item) => SizedBox(
  height: 200,
  child: Carousel(
    boxFit: BoxFit.cover,
    images: item,
    autoplay: true,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(seconds: 1),
    
  ),
);