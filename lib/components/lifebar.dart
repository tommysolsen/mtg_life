import 'dart:math';

import "package:flutter/material.dart";
import 'package:mtg_life/models/life_bar_theme.dart';

class LifeBar extends StatelessWidget {
  LifeBarTheme theme;
  int life;

  Function lifeChangeFunction;

  bool flipped = false;

  LifeBar({this.theme, this.life, this.flipped, this.lifeChangeFunction});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Transform.rotate(
          angle: flipped == true ? pi : 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(color: theme.backgroundColor),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    lifeChangeFunction(-1);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 48.0,
                    color: theme.textColor,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      life.toString(),
                      style: TextStyle(
                          color: life <= 5 ? theme.dangerousLifeTotalColor : theme.textColor,
                          fontSize: 128,
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 24)
                          ]),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      lifeChangeFunction(1);
                    },
                    child: Icon(Icons.arrow_forward,
                        size: 48.0, color: theme.textColor))
              ],
            )),
          ),
      ),
    );
  }
}
