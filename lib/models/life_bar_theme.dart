import 'package:flutter/material.dart';

/// LifeBarTheme describes the layout and look of a single players
/// viewbox.
///
class LifeBarTheme {
  Color backgroundColor;
  Color textColor;
  Color dangerousLifeTotalColor;
  ImageProvider backgroundImage;
  ImageProvider icon;

  LifeBarTheme(
      {this.icon,
      this.backgroundColor,
      this.backgroundImage,
      this.textColor,
      this.dangerousLifeTotalColor});

  static Map<String, LifeBarTheme> get themes {
    return <String, LifeBarTheme>{
      "blue": LifeBarTheme(
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        dangerousLifeTotalColor: Colors.red,
      ),
      "azorius": LifeBarTheme(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage("assets/backgrounds/azorius.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/azorius.png")),
      "boros": LifeBarTheme(
          backgroundColor: Colors.red,
          backgroundImage: AssetImage("assets/backgrounds/boros.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/boros.png")),
      "dimir": LifeBarTheme(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage("assets/backgrounds/dimir.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/dimir.png")),
      "golgari": LifeBarTheme(
          backgroundColor: Colors.green,
          backgroundImage: AssetImage("assets/backgrounds/golgari.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/golgari.png")),
      "gruul": LifeBarTheme(
          backgroundColor: Colors.red,
          backgroundImage: AssetImage("assets/backgrounds/gruul.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/gruul.png")),
      "izzet": LifeBarTheme(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage("assets/backgrounds/izzet.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.red,
          icon: AssetImage("assets/icons/izzet.png")),
      "orzhov": LifeBarTheme(
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage("assets/backgrounds/orzhov.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/orzhov.png")),
      "rakdos": LifeBarTheme(
          backgroundColor: Colors.red,
          backgroundImage: AssetImage("assets/backgrounds/rakdos.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/rakdos.png")),
      "selesnya": LifeBarTheme(
          backgroundColor: Colors.lightGreen,
          backgroundImage: AssetImage("assets/backgrounds/selesnya.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/selesnya.png")),
      "simic": LifeBarTheme(
          backgroundColor: Color(0xFF40e0d0),
          backgroundImage: AssetImage("assets/backgrounds/simic.jpg"),
          textColor: Colors.white,
          dangerousLifeTotalColor: Colors.deepOrange,
          icon: AssetImage("assets/icons/simic.png")),
      "red": LifeBarTheme(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        dangerousLifeTotalColor: Colors.deepOrange,
      )
    };
  }
}
