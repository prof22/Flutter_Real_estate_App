import 'package:flutter/material.dart';
import 'package:real_estate_app/users/widget/drawers.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: DrawerWidget(),
       appBar: AppBar(
         title:Text("Message")
       ),
       body: Center(
          child: Text("Message Page"),
       ),
      
    );
  }
}