// ignore_for_file: avoid_print

import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._init();
  DatabaseHelper._init();
  factory DatabaseHelper() => _instance;

  final _tables = [
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
  ];

  Future<Database> openDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_sipatex.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        _tables.map((table) async {
          return await db
              .execute(table)
              .then(
                (value) => print('table berhasil dibuat'),
              )
              .catchError(
                (e) => print("table gagal dibuat\nError: $e"),
              );
        }).toList();

        await db.insert(
          'users',
          User(
            email: 'admin@gmail.com',
            password: '123456',
            role: 'admin',
            displayName: 'Raffi G',
          ).toJson(),
        );

        await db.insert(
          'users',
          User(
            email: 'guest@gmail.com',
            password: '123456',
            role: 'guest',
            displayName: 'Raffi A',
          ).toJson(),
        );
      },
    );
  }

  void resetTable(String table) async {
    final db = await openDB();
    db.execute('DELETE FROM $table');
  }

  void insert(String table, Map<String, dynamic> data) async {
    await openDB().then((db) {
      db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    }).catchError((e) {
      print("gagal menambahkan data ($e)");
    });
  }

  Future<void> edit(String table, Map<String, dynamic> data, int id) async {
    await openDB().then((db) {
      db.update(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'id = $id',
      );
    }).catchError((e) {
      print("gagal mengedit data ($e)");
    });
  }

  Future<List> get(String table) async {
    final db = await openDB();
    var result = await db.query(table);
    return result.toList();
  }

  void delete(String table, int id) async {
    final db = await openDB();
    db.delete(table, where: 'id = $id');
  }
}
