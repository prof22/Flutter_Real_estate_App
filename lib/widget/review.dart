 import 'package:flutter/material.dart';

review(int total, double activated)
{
    return Row(
      children: List.generate(total, (index) {
        var filled = index < activated;
        // return Icon(filled ? Icons.star : Icons.star_border);
        if(filled)
        {
          return Icon(Icons.star, color:Colors.green);
        }else{
           return Icon(Icons.star_border);
        }
      }).toList(),
    );
} 