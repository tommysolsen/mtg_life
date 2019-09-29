import 'package:flutter/material.dart';

class LifeBarTheme {
  Color backgroundColor;
  Color textColor;
  Color dangerousLifeTotalColor;
  ImageProvider backgroundImage;


  LifeBarTheme({this.backgroundColor, this.backgroundImage, this.textColor, this.dangerousLifeTotalColor});

  static Map<String, LifeBarTheme> get themes {
    return <String, LifeBarTheme>{
      "blue": LifeBarTheme(
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        dangerousLifeTotalColor: Colors.red,
      ),
      "izzet": LifeBarTheme(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage("assets/backgrounds/izzet.jpg"),
        textColor: Colors.white,
        dangerousLifeTotalColor: Colors.red,
      ),
      "red": LifeBarTheme(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        dangerousLifeTotalColor: Colors.deepOrange,
      )
    };
  }
}