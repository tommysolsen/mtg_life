import 'dart:math';

import "package:flutter/material.dart";
import 'package:mtg_life/models/life_bar_theme.dart';

class LifeBar extends StatefulWidget {
  LifeBarTheme theme;
  int life;

  Function lifeChangeFunction;
  Function themeChangeFunction;

  bool flipped = false;

  LifeBar(
      {this.theme,
      this.life,
      this.flipped,
      this.lifeChangeFunction,
      this.themeChangeFunction});

  @override
  _LifeBarState createState() => _LifeBarState();
}

class _LifeBarState extends State<LifeBar> with SingleTickerProviderStateMixin {
  AnimationController ac;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ac =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    ac.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Transform.rotate(
        angle: widget.flipped == true ? pi : 0,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              decoration: BoxDecoration(
                  color: widget.theme.backgroundColor,
                  image: widget.theme.backgroundImage != null
                      ? DecorationImage(
                          image: widget.theme.backgroundImage,
                          fit: BoxFit.cover)
                      : null),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      widget.lifeChangeFunction(-1);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 48.0,
                      color: widget.theme.textColor,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.life.toString(),
                        style: TextStyle(
                            color: widget.life <= 5
                                ? widget.theme.dangerousLifeTotalColor
                                : widget.theme.textColor,
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
                        widget.lifeChangeFunction(1);
                      },
                      child: Icon(Icons.arrow_forward,
                          size: 48.0, color: widget.theme.textColor))
                ],
              )),
            ),
            ac.value >= 0.01
                ? Opacity(
                    opacity: ac.value,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                        ),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            spacing: 25.0,
                            runSpacing: 25.0,
                            direction: Axis.horizontal,
                            children: LifeBarTheme.themes.entries
                                .where((theme) => theme.value.icon != null)
                                .map<Widget>((theme) {
                              return IconButton(
                                  onPressed: () {
                                    ac.reverse();
                                    widget.themeChangeFunction(theme.key);
                                  },
                                  icon: ImageIcon(
                                    theme.value.icon,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                              );
                            }).toList(),
                          ),
                        )
                      ].where((x) => x != null).toList(),
                    ))
                : null,
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                onPressed: () {
                  if (ac.isCompleted) {
                    ac.reverse();
                  } else {
                    ac.forward();
                  }
                },
                icon: Icon(Icons.color_lens, color: widget.theme.textColor,),
              ),
            )
          ].where((x) => x != null).toList(),
        ),
      ),
    );
  }
}
