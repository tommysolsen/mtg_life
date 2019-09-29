import "package:flutter/material.dart";

class LifeMenu extends StatefulWidget {
  @override
  _LifeMenuState createState() => _LifeMenuState();
}

class _LifeMenuState extends State<LifeMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.white),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.white),
        )
      ],
    );
  }
}
