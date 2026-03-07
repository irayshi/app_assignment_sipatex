import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AuthProvider {
  static AuthProvider get to => Get.find();

  final Database _db;
  AuthProvider({required Database db}) : _db = db;

  Future<void> saveSession({
    required int userId,
    required bool isLoggedIn,
  }) async {
    await _db.insert('sessions', {
      'id': 1,
      'userId': userId,
      'isLoggedIn': isLoggedIn ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int?> getCurrentUserId() async {
    final rows = await _db.query('sessions', where: 'id = 1');
    if (rows.isEmpty) return null;
    final row = rows.first;
    if (row['isLoggedIn'] as int != 1) return null;
    return row['userId'] as int?;
  }

  Future<int> login({required String email, required String password}) async {
    final row = await _db.query(
      'users',
      columns: ['id'],
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (row.isEmpty) {
      throw 'Email atau password salah';
    }
    return row.first['id'] as int;
  }

  Future<int> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final id = await _db.insert('users', {
        'email': email,
        'password': password,
        'name': name,
      });
      return id;
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw 'Email ini sudah terdaftar.';
      }
      rethrow;
    }
  }
}
