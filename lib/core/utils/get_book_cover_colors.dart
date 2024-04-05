import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khalifa/core/enums/enum.dart';

Color getCoverColor({required TypeOfBooks typeOfBooks}) {
  final List<Color> colorList = [
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.deepOrangeAccent,
    Colors.lightGreenAccent
  ];
  final List<Color> islamicColorList = [
    Colors.greenAccent,
    Colors.green,
    Colors.lightGreen,
    Colors.lightGreenAccent
  ];
  final List<Color> historyColorList = [
    Colors.blueGrey,
    Colors.grey,
    Colors.white10,
    Colors.white38
  ];
  final List<Color> politicsColorList = [
    Colors.teal,
    Colors.tealAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
  ];

  var rng = Random();
  final randomNumber = rng.nextInt(colorList.length);
  if (typeOfBooks == TypeOfBooks.islam) {
    return islamicColorList[randomNumber];
  } else if (typeOfBooks == TypeOfBooks.politics) {
    return politicsColorList[randomNumber];
  } else if (typeOfBooks == TypeOfBooks.history) {
    return historyColorList[randomNumber];
  } else {
    return colorList[randomNumber];
  }
}
