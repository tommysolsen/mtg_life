import 'dart:math';

import "package:flutter/material.dart";
import 'package:mtg_life/models/app_configuration.dart';
import 'package:provider/provider.dart';
import 'package:mtg_life/player_screens/player_screens.dart';

class LifeMenu extends StatefulWidget {
  final Function resetLifeTotals;
  final Function setLifeTotals;
  final AnimationController parentController;
  final AnimationController screenChangeAnimation;

  LifeMenu({this.setLifeTotals, this.resetLifeTotals, this.parentController, this.screenChangeAnimation});

  @override
  _LifeMenuState createState() => _LifeMenuState();
}

class _LifeMenuState extends State<LifeMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation translateAnimation;
  String _currentMenu;

  String get currentMenu {
    return _currentMenu;
  }

  set currentMenu(String menu) {
    setState(() {
      _currentMenu = menu;
    });
    if (menu != null) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    animationController.addListener(() {
      setState(() {});
    });
    translateAnimation =
        Tween(begin: 0.0, end: 30.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.linear)
        );
    widget.parentController.addListener(() {
      if(widget.parentController.status == AnimationStatus.dismissed && currentMenu != null) {
        currentMenu = null;
      }
    });
  }

  Widget buildCurrentMenu(BuildContext context) {
    switch (_currentMenu) {
      case "LifeMenu":
        return Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      widget.setLifeTotals(20);
                      Future.delayed(Duration(milliseconds: 500), () {
                        currentMenu = null;
                      });
                    },
                    child: Text("20", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                    )),
                  ),
                  FlatButton(
                    onPressed: () async {
                      widget.setLifeTotals(30);
                      Future.delayed(Duration(milliseconds: 500), () {
                        currentMenu = null;
                      });
                    },
                    child: Text("30", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                    )),
                  ),
                  FlatButton(
                    onPressed: () async {
                      widget.setLifeTotals(40);
                      Future.delayed(Duration(milliseconds: 500), () {
                        currentMenu = null;
                      });
                    },
                    child: Text("40", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                    )),
                  )
                ]));
      case "Players":
        return Consumer<AppConfiguration>(
          builder: (_ctx, appConfig, _w) => Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    await widget.screenChangeAnimation.forward();
                    appConfig.setPlayerScreen(PlayerScreens.TWO_PLAYER);
                    widget.screenChangeAnimation.reverse();
                  },
                  child: Text("2", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400
                  )),
                ),
                FlatButton(
                  onPressed: () async {
                    await widget.screenChangeAnimation.forward();
                    appConfig.setPlayerScreen(PlayerScreens.THREE_PLAYER);
                    widget.screenChangeAnimation.reverse();
                  },
                  child: Text("3", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400
                  )),
                ),
                FlatButton(
                  onPressed: () async {
                    await widget.screenChangeAnimation.forward();
                    appConfig.setPlayerScreen(PlayerScreens.FOUR_PLAYER);
                    widget.screenChangeAnimation.reverse();
                  },
                  child: Text("4", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400
                  )),
                ),
              ],
            )
          ),
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double translateShift = translateAnimation.value * -1;
    return Opacity(
      opacity: 1 - min(widget.screenChangeAnimation.value*2.0, 1.0),
      child: Transform.translate(
        offset: Offset(0, 0),
            child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 1.0 - animationController.value,
              child: Transform.translate(
                offset: Offset(0, translateShift + -2),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          widget.resetLifeTotals();
                        },
                        icon: Icon(
                          Icons.autorenew,
                          color: Colors.white,
                          size: 36
                        )
                      ),
                      IconButton(
                          onPressed: () {
                            currentMenu = "LifeMenu";
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 36,
                          )),
                      IconButton(
                        onPressed: () => currentMenu = "Players",
                        icon: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.white,
                          size: 36
                        )
                      ),
                      IconButton(
                          onPressed: () => currentMenu = "Info",
                          icon: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 36
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Opacity(
                opacity: animationController.value,
                child: Transform.translate(
                    offset: Offset(0, 30.0 + translateShift),
                    child: buildCurrentMenu(context)))
          ],
        ),
      ),
    );
  }
}
