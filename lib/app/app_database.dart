import 'package:app_assignment_sipatex/app/app_info.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

class AppDatabase {
  Future<Database> init({bool test = false}) async {
    if (GetPlatform.isDesktop || test) {
      ffi.sqfliteFfiInit();
      ffi.databaseFactory = ffi.databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = test
        ? inMemoryDatabasePath
        : join(dbPath, '${AppInfo.package}.db');

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
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            qty INTEGER NOT NULL,
            shop_id INTEGER NOT NULL,
            price INTEGER NOT NULL,
            rating REAL,
            images TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE review_products(
            id INTEGER PRIMARY KEY,
            user_id INTEGER,
            text TEXT NOT NULL,
            rating INTEGER NOT NULL,
            order_id INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY,
            user_id INTEGER NOT NULL,
            status TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE order_items(
            id INTEGER PRIMARY KEY,
            product_id INTEGER NOT NULL,
            order_id INTEGER NOT NULL,
            qty INTEGER NOT NULL,
            price INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE shops(
            id INTEGER PRIMARY KEY,
            user_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            slug TEXT NOT NULL UNIQUE,
            rating REAL,
            follower INTEGER NOT NULL 
          )
        ''');
        await _exampleUser(db);
      },
    );
  }

  Future<void> _exampleUser(Database db) async {
    await db.insert('users', {
      'email': 'test@gmail.com',
      'password': '123',
      'name': 'test',
    });
  }
}
