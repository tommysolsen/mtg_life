import "package:flutter/material.dart";

import 'counter.dart';

class Player with ChangeNotifier {
  Map<Counter, int> counters;


  Player([int life = 20]) {
    counters = new Map();
    counters[Counter.LIFE] = life;
  }

  int getValueOf(Counter c) {
    return counters.containsKey(c) ? counters[c] : 0;
  }

  void setValueOf(Counter c, int v) {
    counters[c] = v;
    notifyListeners();
  }

  void adjustValueOf(Counter c, int v) {
    counters[c] = counters[c] + v;
  }
}