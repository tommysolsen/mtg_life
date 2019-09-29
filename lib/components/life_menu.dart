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
          onPressed: () {
            widget.resetLifeTotals(20);
          },
          icon: Stack(
            children: <Widget>[
              Center(child: Icon(Icons.favorite_border, color: Colors.white, size: 32,)),
              Center(child: Text("20", style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),))
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            widget.resetLifeTotals(30);
          },
          icon: Stack(
            children: <Widget>[
              Center(child: Icon(Icons.favorite_border, color: Colors.white, size: 32,)),
              Center(child: Text("30", style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),))
            ],
          ),
        ),IconButton(
          onPressed: () {
            widget.resetLifeTotals(40);
          },
          icon: Stack(
            children: <Widget>[
              Center(child: Icon(Icons.favorite_border, color: Colors.white, size: 32,)),
              Center(child: Text("40", style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),))
            ],
          ),
        ),
      ],
    );
  }
}
