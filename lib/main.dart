import 'dart:io';

import 'package:app_assignment_sipatex/app/core/values/colors.dart';
import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  Get.put(AuthService());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application Assignment Sipatex",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
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
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
