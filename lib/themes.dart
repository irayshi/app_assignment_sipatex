import 'package:app_assignment_sipatex/app/core/values/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final dark = ThemeData(
    brightness: Brightness.dark,
    canvasColor: primaryColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      onSecondary: Colors.white,
      error: errorColor,
      onError: Colors.white,
      surface: black,
      onSurface: white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(fontSize: 16),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: secondaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    listTileTheme: const ListTileThemeData(horizontalTitleGap: 30),
    iconTheme: const IconThemeData(color: white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: black,
      selectedItemColor: white,
      unselectedItemColor: white.withOpacity(0.5),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: white),
  );
}
