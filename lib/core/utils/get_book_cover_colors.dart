import 'dart:math';

import 'package:flutter/material.dart';

Color getCoverColor() {
  final List<Color> colorList = [
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.deepOrangeAccent,
    Colors.lightGreenAccent
  ];
  var rng = Random();
  final randomNumber = rng.nextInt(colorList.length);
  return colorList[randomNumber];
}
