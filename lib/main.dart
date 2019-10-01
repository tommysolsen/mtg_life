import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mtg_life/components/life_menu.dart';
import 'package:mtg_life/components/lifebar.dart';
import 'package:wakelock/wakelock.dart';

import 'models/life_bar_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Lifecounter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xFF38322A),
      body: Stack(
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
                
                  child: Container(
                    margin: EdgeInsets.only(bottom: marginAnimation.value),
                    child: LifeDisplay(
                      theme: LifeBarTheme.themes[p1Theme],
                      life: p1Life,
                      flipped: true,
                      lifeChangeFunction: _changeLifeP1,
                      themeChangeFunction: _changeP1Theme,
                      dragUpdate: onVerticalDragUpdate,
                      dragEnd: onVerticalDragEnd,
                    ),
                  ),
              ),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: marginAnimation.value),
                    child: LifeDisplay(
                      theme: LifeBarTheme.themes[p2Theme],
                      life: p2Life,
                      flipped: false,
                      lifeChangeFunction: _changeLifeP2,
                      themeChangeFunction: _changeP2Theme,
                      dragUpdate: onVerticalDragUpdate,
                      dragEnd: onVerticalDragEnd
                    ),
                  ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
