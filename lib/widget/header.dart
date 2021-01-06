import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "Real Estate" : titleText,
      style: TextStyle(color: 
      Colors.white,
       fontSize: 12.0,
       ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
