import 'package:flutter/material.dart';

abstract class Themes {
  static ThemeData get light => ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
