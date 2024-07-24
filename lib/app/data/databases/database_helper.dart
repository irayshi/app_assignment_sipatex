// ignore_for_file: avoid_print

import 'dart:async';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._init();
  DatabaseHelper._init();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_sipatex.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    print('_onCreate');
    await db.execute(
      '''
      CREATE TABLE users
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT DEFAULT 'guest' NOT NULL,
        displayName TEXT NOT NULL
      )
      ''',
    );
    await db.execute(
      '''
      CREATE TABLE products
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productCategory TEXT NOT NULL,
        name TEXT NOT NULL UNIQUE,
        brand TEXT,
        description TEXT NOT NULL,
        basePrice INT NOT NULL,
        inStock BOOLEAN NOT NULL,
        stock INT NOT NULL,
        featuredImage TEXT,
        thumbnailImage TEXT,
        storageOptions TEXT,
        colorOptions TEXT,
        display TEXT,
        CPU TEXT,
        GPU TEXT,
        camera JSON
      )
      ''',
    );

    await db.insert(
      'users',
      User(
        email: 'admin@gmail.com',
        password: '123456',
        role: 'admin',
        displayName: 'Raffi A',
      ).toJson(),
    );
    await db.insert(
      'users',
      User(
        email: 'guest@gmail.com',
        password: '123456',
        role: 'guest',
        displayName: 'Raffi G',
      ).toJson(),
    );
  }

  FutureOr<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {}
}
