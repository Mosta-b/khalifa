import 'package:flutter/material.dart';

const colorPrimary = Color(0xFF16697A);
const colorSecondary = Color(0xFF489FB5);
const colorBackground = Color(0xFFEDE7E3);
const colorSurface = Color(0xFFFFA62B);

ThemeData lightTheme = ThemeData(
  // app theme
  visualDensity: VisualDensity.adaptivePlatformDensity,
  useMaterial3: true,
  colorSchemeSeed: colorPrimary,
  scaffoldBackgroundColor: const Color(0xFFEDE7E3),
  // floatingActionButton  Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: colorPrimary,
  ),
  // AppBar Theme
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color(0xFFEDE7E3),
    titleTextStyle: TextStyle(fontFamily: 'Quicksand Medium', fontSize: 24, color: Colors.black),
  ),

  // text theme
  textTheme: const TextTheme(),
  fontFamily: 'Quicksand Medium',
);

ThemeData darkTheme = lightTheme.copyWith(
    colorScheme: lightTheme.colorScheme.copyWith(
      // Change primary and secondary colors for dark theme
      primary: Colors.blueGrey.shade800, // Example primary color for dark theme
      secondary: Colors.teal, // Example secondary color for dark theme
    ),
    searchViewTheme: lightTheme.searchViewTheme.copyWith(backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: Colors.blueGrey.shade200,
    textTheme: lightTheme.textTheme.copyWith(
      displayMedium: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: lightTheme.bottomNavigationBarTheme.copyWith(backgroundColor: Colors.grey),
    cardTheme: lightTheme.cardTheme.copyWith(color: Colors.grey),
    appBarTheme: lightTheme.appBarTheme.copyWith(
      backgroundColor: Colors.transparent,
      titleTextStyle: const TextStyle(
        fontFamily: 'Quicksand Medium',
        fontSize: 24,
      ),
    ),
    floatingActionButtonTheme: lightTheme.floatingActionButtonTheme.copyWith(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blueGrey,
    ));

// ThemeData(
//   brightness: Brightness.dark,
//   fontFamily: 'Quicksand Medium',
//   useMaterial3: true,
//   colorSchemeSeed: colorPrimary,
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     backgroundColor: colorPrimary,
//   ),
//   appBarTheme: const AppBarTheme(
//     titleTextStyle: TextStyle(fontFamily: 'Quicksand Medium', fontSize: 24),
//   ),
//   textTheme: const TextTheme(),
// );
