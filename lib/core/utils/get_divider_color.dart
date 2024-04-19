import 'package:flutter/material.dart';

Color getDividerColor({required BuildContext context}) {
  final Brightness brightness = Theme.of(context).brightness;
  final bool isDarkMode = brightness == Brightness.dark;
  if (isDarkMode) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}
