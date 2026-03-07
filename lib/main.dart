import 'package:app_assignment_sipatex/app/app_database.dart';
import 'package:app_assignment_sipatex/app/app_info.dart';
import 'package:app_assignment_sipatex/app/routes.dart';
import 'package:app_assignment_sipatex/app/themes.dart';
import 'package:app_assignment_sipatex/providers/auth_provider.dart';
import 'package:app_assignment_sipatex/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await Get.putAsync<Database>(() => AppDatabase().database);
  Get.lazyPut(() => AuthProvider(db: db));
  Get.lazyPut(() => AuthService(authProvider: AuthProvider.to));
  await AuthService.to.loadSession();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppInfo.name,
      initialRoute: AuthService.to.userId == null ? Routes.login : Routes.home,
      getPages: Routes.pages,
      theme: Themes.light,
    );
  }
}
