import "package:flutter/widgets.dart";
class SlideSwapContainer extends StatelessWidget {
  final Widget child;
  Animation animation;

  SlideSwapContainer({this.child, controller, context}) {
    animation = Tween(begin: 0.0, end: MediaQuery.of(context).size.height/2).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut)
    );
  }
  @override
  Widget build(BuildContext context) {

    return Transform.translate(
        offset: Offset(0, animation.value),
        child: child
    );
  }
}
