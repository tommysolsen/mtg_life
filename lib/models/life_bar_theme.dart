import 'package:flutter/material.dart';

class LifeBarTheme {
  Color backgroundColor;
  Color textColor;
  Color dangerousLifeTotalColor;


  LifeBarTheme({this.backgroundColor, this.textColor, this.dangerousLifeTotalColor});

  static Map<String, LifeBarTheme> get themes {
    return <String, LifeBarTheme>{
      "blue": LifeBarTheme(
        backgroundColor: Colors.blue,
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