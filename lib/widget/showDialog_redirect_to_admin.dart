import 'package:flutter/material.dart';

showdialogToContact(context, String title, String message, Function redirect){
    showDialog(
      context:context ,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text('$title'),
          content:  new Text('$message'),
          actions: <Widget>[
               new RaisedButton(

              child: new Text(
                'Ok',
                 ),

              onPressed: (){
                redirect();
              },

            ),
            new RaisedButton(

              child: new Text(
                'Close',
                 ),

              onPressed: (){
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      }
    );
  }