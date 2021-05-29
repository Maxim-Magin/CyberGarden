import 'package:flutter/material.dart';

class Design{
  static Color themeColor(){
    return Colors.blueAccent;
  }

  static Color circleItemColor(){
    return Colors.white;
  }

  static Color disableColor(){
    return Color(0xC8D6D6D6);
  }

  static TextStyle regularTextStyle(){
    return TextStyle(
      fontSize: 24.0,
      fontFamily: "Montserrat",
    );
  }
  static TextStyle iconTextStyle(){
    return TextStyle(
      fontSize: 16.0,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.bold
    );
  }
  static TextStyle titleTextStyle(){
    return TextStyle(
      fontSize: 28.0,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(1.5, 1.5),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    );
  }
}