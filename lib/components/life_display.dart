import "package:flutter/material.dart";
import 'package:mtg_life/models/life_bar_theme.dart';
import 'package:mtg_life/models/player.dart';
import 'package:mtg_life/models/counter.dart';

class LifeDisplay extends StatefulWidget {
  final LifeBarTheme theme;
  final Player player;
  final Function themeChangeFunction;

  LifeDisplay(
      {
        this.theme,
        this.player,
        this.themeChangeFunction,
      }) : assert(player != null);

  @override
  _LifeBarState createState() => _LifeBarState();

  get life {
    return this.player.getValueOf(Counter.LIFE);
  }
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
        currentHealth = widget.player.getValueOf(Counter.LIFE);
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
    healthDiff.value = 0.01;
    healthDiff.forward();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mc = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => Material(
        elevation: 4,
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
                        widget.player.adjustValueOf(Counter.LIFE, -1);
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
                              fontSize: widget.life >= 100
                                  ? constraints.maxHeight * 0.3
                                  : constraints.maxHeight * 0.4,
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
                          widget.player.adjustValueOf(Counter.LIFE, 1);
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
                              spacing: constraints.maxHeight == mc.size.height / 2
                                  ? constraints.maxWidth * 0.07
                                  : constraints.maxWidth * 0.04,
                              runSpacing: constraints.maxHeight == mc.size.height / 2
                                ? constraints.maxHeight * 0.07
                                : constraints.maxHeight * 0.02,
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

              healthDiff.value > 0 ? Positioned(
                top: constraints.maxHeight * 0.15,
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
