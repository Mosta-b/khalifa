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
    Colors.teal.shade900,
    Colors.tealAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
  ];

  var rng = Random();
  final randomNumber = rng.nextInt(colorList.length);
  if (typeOfBooks == TypeOfBooks.islam) {
    final randomNumberForIslamicBook = rng.nextInt(islamicColorList.length);
    return islamicColorList[randomNumberForIslamicBook];
  } else if (typeOfBooks == TypeOfBooks.politics) {
    final randomNumberForPolitics = rng.nextInt(politicsColorList.length);
    return politicsColorList[randomNumberForPolitics];
  } else if (typeOfBooks == TypeOfBooks.history) {
    final randomNumberForHistory = rng.nextInt(historyColorList.length);
    return historyColorList[randomNumberForHistory];
  } else {
    return colorList[randomNumber];
  }
}
