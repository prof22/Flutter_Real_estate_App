import 'package:flutter/material.dart';
import 'package:real_estate_app/screen/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[400],
        accentColor: Colors.green[800],
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline:TextStyle(
            fontSize: 27.0, fontWeight: FontWeight.bold
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      // home:NewHomePage()
      home: HomeScreen(),
    );
  }
}