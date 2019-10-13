import 'dart:math';

import "package:flutter/material.dart";
import 'package:mtg_life/components/life_display.dart';
import 'package:mtg_life/components/life_display_container.dart';
import 'package:mtg_life/components/life_menu.dart';
import 'package:mtg_life/components/slide_swap_container.dart';
import 'package:mtg_life/models/life_bar_theme.dart';
import 'package:mtg_life/models/player.dart';
import 'package:wakelock/wakelock.dart';

class TwoPlayerScreen extends StatefulWidget {
  AnimationController screenChangeController;

  TwoPlayerScreen(this.screenChangeController);
  @override
  _TwoPlayerScreenState createState() => _TwoPlayerScreenState();
}

class _TwoPlayerScreenState extends State<TwoPlayerScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation marginAnimation;

  _TwoPlayerScreenState() {
    this.p1 = Player(stdLife);
    this.p2 = Player(stdLife);
  }

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

  Player p1;
  Player p2;
  int stdLife = 20;

  String p1Theme = "azorius";
  String p2Theme = "izzet";

  void _setLifeTotal(int value) {
    setState(() {
      p1 = new Player(value);
      p2 = new Player(value);
      stdLife = value;
      animationController.reverse();
    });
  }

  void _resetLifeTotal() {
    setState(() {
      p1 = new Player(stdLife);
      p2 = new Player(stdLife);
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
    var changeAnimationOffset = MediaQuery.of(context).size.height/2;
    return Stack(
      children: <Widget>[
        Center(
            child: LifeMenu(
              resetLifeTotals: _resetLifeTotal,
              setLifeTotals: _setLifeTotal,
              parentController: animationController,
              screenChangeAnimation: widget.screenChangeController,
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
                    child: SlideSwapContainer(
                      context: context,
                      controller: widget.screenChangeController,
                      child: LifeDisplayContainer(
                        onVerticalDragUpdate: onVerticalDragUpdate,
                        onVerticalDragEnd: onVerticalDragEnd,
                        child: LifeDisplay(
                          player: p1,
                          theme: LifeBarTheme.themes[p1Theme],
                          themeChangeFunction: _changeP1Theme,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            Expanded(
              child: Transform.translate(
                  offset: Offset(0, marginAnimation.value),
                  child: SlideSwapContainer(
                    controller: widget.screenChangeController,
                    context: context,
                    child: LifeDisplayContainer(
                      onVerticalDragEnd: onVerticalDragEnd,
                      onVerticalDragUpdate: onVerticalDragUpdate,
                      child: LifeDisplay(
                        player: p2,
                        theme: LifeBarTheme.themes[p2Theme],
                        themeChangeFunction: _changeP2Theme,
                      ),
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
