import 'package:app_assignment_sipatex/models/user.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider {
  static UserProvider get to => Get.find();

  final Database _db;
  UserProvider({required Database db}) : _db = db;

  Future<User> getUser(int id) async {
    final row = await _db.query('users', where: 'id = ?', whereArgs: [id]);
    if (row.isEmpty) throw 'Data user tidak ditemukan';
    return User.fromMap(row.first);
  }
}
