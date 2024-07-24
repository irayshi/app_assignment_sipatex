import 'package:app_assignment_sipatex/app/data/databases/database_helper.dart';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider extends GetxController {
  static UserProvider get to => Get.find();
  late Database _database;
  final users = <User>[].obs;

  @override
  void onInit() async {
    _database = await DatabaseHelper().database;
    users.value = await _getLocal();
    super.onInit();
  }

  Future<List<User>> _getLocal() async {
    final data = await _database.query('users');

    return data.map((e) => User.fromJson(e)).toList();
  }

  void delete(int id) async {
    await _database.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void create(User user) async {
    final data = {
      'id': user.id,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'displayName': user.displayName,
    };
    await _database.insert('users', data);
  }

  void edit(User user) async {
    final data = {
      'id': user.id,
      'email': user.email,
      'role': user.role,
      'displayName': user.displayName,
    };
    await _database.update(
      'users',
      data,
      where: 'id = ?',
      whereArgs: [user.id!],
    );
  }

  Future<bool> checkEmail(String email) async {
    final users = await _database.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return users.isEmpty ? false : true;
  }
}
