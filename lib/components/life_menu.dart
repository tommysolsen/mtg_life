import "package:flutter/material.dart";

class LifeMenu extends StatefulWidget {
  Function resetLifeTotals;

  LifeMenu({this.resetLifeTotals});

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
                      widget.resetLifeTotals(20);
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
                      widget.resetLifeTotals(30);
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
                      widget.resetLifeTotals(40);
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
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double translateShift = translateAnimation.value * -1;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 1.0 - animationController.value,
          child: Transform.translate(
            offset: Offset(0, translateShift),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        currentMenu = "LifeMenu";
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 36,
                      )),
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
    );
  }
}
