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
    MediaQueryData mq = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          child: GestureDetector(
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            child:
            Container(
              color: Color(0x01000000),
              height: mq.size.height * 0.15,
            ),
          ),
        )
      ],
    );
  }
}
