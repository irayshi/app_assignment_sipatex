import 'dart:io';

import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/themes.dart';
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
      theme: Themes.dark,
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
