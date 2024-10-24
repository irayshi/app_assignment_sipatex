import 'package:app_assignment_sipatex/app/data/services/database_service.dart';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider extends GetxController {
  static UserProvider get to => Get.find();
  final users = <User>[].obs;

  @override
  void onInit() async {
    await initUsers();
    super.onInit();
  }

  Future<void> initUsers() async {
    users.value = await _getLocal();
  }

  Future<List<User>> _getLocal() async {
    try {
      final data = await DatabaseService.to.query('users');
      return data.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      Get.rawSnackbar(
          message: 'Error: saat mengambil data users dari database. Mohon refresh halaman!');
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    await DatabaseService.to.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    await initUsers();
  }

  Future<void> create(User user) async {
    final data = {
      'id': user.id,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'displayName': user.displayName,
    };
    await DatabaseService.to.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await initUsers();
  }

  Future<void> edit(User user) async {
    final data = {
      'id': user.id,
      'email': user.email,
      'role': user.role,
      'displayName': user.displayName,
    };
    await DatabaseService.to.update(
      'users',
      data,
      where: 'id = ?',
      whereArgs: [user.id!],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await initUsers();
  }

  Future<bool> emailExists(String email) async {
    final users = await DatabaseService.to.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return users.isEmpty ? false : true;
  }
}
