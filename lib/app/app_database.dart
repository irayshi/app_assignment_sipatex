import 'package:app_assignment_sipatex/app/app_info.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

class AppDatabase {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  Future<Database> _init() async {
    if (GetPlatform.isDesktop) {
      ffi.sqfliteFfiInit();
      ffi.databaseFactory = ffi.databaseFactoryFfi;
    }
    
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '${AppInfo.package}.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE sessions(
            id INTEGER PRIMARY KEY,
            userId INTEGER,
            isLoggedIn INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }
}
