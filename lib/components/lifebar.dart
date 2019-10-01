import 'dart:math';

import "package:flutter/material.dart";
import 'package:mtg_life/models/life_bar_theme.dart';

class LifeDisplay extends StatefulWidget {
  final LifeBarTheme theme;
  final int life;

  final Function lifeChangeFunction;
  final Function themeChangeFunction;

  final Function dragUpdate;
  final Function dragEnd;

  final bool flipped;

  LifeDisplay(
      {this.theme,
      this.life,
      this.flipped,
      this.lifeChangeFunction,
      this.themeChangeFunction,
      this.dragUpdate,
      this.dragEnd});

  @override
  _LifeBarState createState() => _LifeBarState();
}

class _LifeBarState extends State<LifeDisplay> with TickerProviderStateMixin {
  AnimationController ac;
  AnimationController healthDiff;
  Animation healthDiffAnimation;
  int currentHealth;

  @override
  void initState() {
    super.initState();
    ac =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    ac.addListener(() {
      setState(() {});
    });

    healthDiff = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1600));
    healthDiffAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: healthDiff, curve: Interval(0.75, 1.0,curve: Curves.easeIn))
    );
    healthDiff.addListener(() {
      if (healthDiff.isCompleted) {
        currentHealth = widget.life;
        healthDiff.value = 0;
      }
      setState(() {});
    });
    if (currentHealth == null) {
      currentHealth = widget.life;
    }
  }

  void showDiff() {
    if (!healthDiff.isAnimating) {
      currentHealth = widget.life;
    }
    healthDiff.value = 0;
    healthDiff.forward();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mc = MediaQuery.of(context);
    return Material(
      elevation: 4,
      child: Transform.rotate(
        angle: widget.flipped == true ? pi : 0,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: widget.theme.backgroundColor,
                  image: widget.theme.backgroundImage != null
                      ? DecorationImage(
                          image: widget.theme.backgroundImage,
                          fit: BoxFit.cover)
                      : null),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDiff();
                      widget.lifeChangeFunction(-1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 48.0,
                        color: widget.theme.textColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.life.toString(),
                        style: TextStyle(
                            color: widget.life <= 5
                                ? widget.theme.dangerousLifeTotalColor
                                : widget.theme.textColor,
                            fontSize: 128,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 24)
                            ]),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDiff();
                        widget.lifeChangeFunction(1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_forward,
                            size: 48.0, color: widget.theme.textColor),
                      ))
                ],
              )),
            ),
            ac.value >= 0.01
                ? Opacity(
                    opacity: ac.value,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                        ),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            spacing: 25.0,
                            runSpacing: 25.0,
                            direction: Axis.horizontal,
                            children: LifeBarTheme.themes.entries
                                .where((theme) => theme.value.icon != null)
                                .map<Widget>((theme) {
                              return IconButton(
                                onPressed: () {
                                  ac.reverse();
                                  widget.themeChangeFunction(theme.key);
                                },
                                icon: ImageIcon(
                                  theme.value.icon,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ].where((x) => x != null).toList(),
                    ))
                : null,
            GestureDetector(
              onVerticalDragUpdate: widget.dragUpdate,
              onVerticalDragEnd: widget.dragEnd,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.16,
                decoration: BoxDecoration(
                  color: Color(0x01000000),
                ),
              ),
            ),
            healthDiff.value > 0 ? Positioned(
              top: mc.size.height * 0.10,
              left: mc.size.width / 3,
              right: mc.size.width / 3,
              child: Opacity(
                opacity: healthDiffAnimation.value,
                child: Text(
                  "${currentHealth < widget.life ? '+' : '-'}${(currentHealth - widget.life).abs()}",
                  style: TextStyle(color: widget.theme.textColor, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ): null,
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                onPressed: () {
                  if (ac.isCompleted) {
                    ac.reverse();
                  } else {
                    ac.forward();
                  }
                },
                icon: Icon(
                  Icons.color_lens,
                  color: widget.theme.textColor,
                ),
              ),
            ),
          ].where((x) => x != null).toList(),
        ),
      ),
    );
  }
}
