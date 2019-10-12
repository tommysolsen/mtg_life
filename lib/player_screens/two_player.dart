import 'dart:math';

import "package:flutter/material.dart";
import 'package:mtg_life/components/life_display.dart';
import 'package:mtg_life/components/life_display_container.dart';
import 'package:mtg_life/components/life_menu.dart';
import 'package:mtg_life/models/life_bar_theme.dart';
import 'package:wakelock/wakelock.dart';

class TwoPlayerScreen extends StatefulWidget {
  @override
  _TwoPlayerScreenState createState() => _TwoPlayerScreenState();
}

class _TwoPlayerScreenState extends State<TwoPlayerScreen>     with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation marginAnimation;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();

    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animationController.addListener(() {
      setState(() {});
    });
    marginAnimation = Tween(begin: 0.0, end: 25.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
  }

  int p1Life = 20;
  int p2Life = 20;
  int stdLife = 20;

  String p1Theme = "azorius";
  String p2Theme = "izzet";

  void _setLifeTotal(int value) {
    setState(() {
      p1Life = value;
      p2Life = value;
      stdLife = value;
      animationController.reverse();
    });
  }

  void _resetLifeTotal() {
    setState(() {
      p1Life = stdLife;
      p2Life = stdLife;
    });
    animationController.reverse();
  }

  void _changeP1Theme(String theme) {
    setState(() {
      p1Theme = theme;
    });
  }

  void _changeP2Theme(String theme) {
    setState(() {
      p2Theme = theme;
    });
  }

  void _changeLifeP1(int amount) {
    setState(() {
      p1Life = max(0, p1Life + amount);
    });
  }

  void _changeLifeP2(int amount) {
    setState(() {
      p2Life = max(0, p2Life + amount);
    });
  }

  void onVerticalDragUpdate(DragUpdateDetails update) {
    setState(() {
      double distance = update.delta.distance / 40;
      if (update.delta.dy < 0) {
        animationController.value -= distance;
      } else if (update.delta.dy > 0) {
        animationController.value += distance;
      }
    });
  }

  void onVerticalDragEnd(DragEndDetails d) {
    if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: LifeMenu(
              resetLifeTotals: _resetLifeTotal,
              setLifeTotals: _setLifeTotal,
              parentController: animationController,
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Transform.translate(
                offset: Offset(0, marginAnimation.value * -1),
                child: Transform.rotate(
                  angle: pi,
                  child: LifeDisplayContainer(
                    onVerticalDragUpdate: onVerticalDragUpdate,
                    onVerticalDragEnd: onVerticalDragEnd,
                    child: LifeDisplay(
                      theme: LifeBarTheme.themes[p1Theme],
                      life: p1Life,
                      flipped: true,
                      lifeChangeFunction: _changeLifeP1,
                      themeChangeFunction: _changeP1Theme,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, marginAnimation.value),
                child: LifeDisplayContainer(
                  onVerticalDragEnd: onVerticalDragEnd,
                  onVerticalDragUpdate: onVerticalDragUpdate,
                  child: LifeDisplay(
                    theme: LifeBarTheme.themes[p2Theme],
                    life: p2Life,
                    flipped: false,
                    lifeChangeFunction: _changeLifeP2,
                    themeChangeFunction: _changeP2Theme,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
