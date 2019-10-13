import "package:flutter/material.dart";

class LifeDisplayContainer extends StatelessWidget {
  final Widget child;
  final Function onVerticalDragUpdate;
  final Function onVerticalDragEnd;

  LifeDisplayContainer({
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.child
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Positioned(
          child: GestureDetector(
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            child: child,
          ),
        )
      ],
    );
  }
}
