import 'package:flutter/material.dart';

showdialog(context, String title, String message){
    showDialog(
      context:context ,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text('$title'),
          content:  new Text('$message'),
          actions: <Widget>[
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