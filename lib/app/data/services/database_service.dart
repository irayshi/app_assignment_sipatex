// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:app_assignment_sipatex/app/data/services/tables/products_table.dart';
import 'package:app_assignment_sipatex/app/data/services/tables/users_table.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends GetxService {
  static Database get to => Get.find<DatabaseService>()._database!;
  Database? _database;

  @override
  void onInit() async {
    _database = await _openDB();
    super.onInit();
  }

  @override
  void onClose() {
    _database?.close();
    super.onClose();
  }

  Future<Database> _openDB() async {
    String dbPath;
    if (Platform.isAndroid) {
      dbPath = await getDatabasesPath();
    } else {
      final documentPath = await getApplicationDocumentsDirectory();
      dbPath = documentPath.path;
    }
    final path = join(dbPath, 'app_sipatex.db');

    return databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await usersTable(db);
    await productsTable(db);

    await db.insert(
      tblUsers,
      User(
        email: 'admin@gmail.com',
        password: '123456',
        role: 'admin',
        displayName: 'Raffi A',
      ).toJson(),
    );
    await db.insert(
      tblUsers,
      User(
        email: 'guest@gmail.com',
        password: '123456',
        role: 'guest',
        displayName: 'Raffi G',
      ).toJson(),
    );
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}
}
