import 'package:app_assignment_sipatex/app/data/databases/database_helper.dart';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final _user = Rx<User?>(null);
  User get user => _user.value!;

  late Database _database;

  @override
  void onInit() async {
    _database = await DatabaseHelper().openDB();
    super.onInit();
  }

  Future<bool> login(String email, String password) async {
    String message;
    bool status;
    try {
      final users = await _database.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      if (users.isNotEmpty) {
        message = 'Login berhasil';
        status = true;
        _user.value = User.fromJson(users.first);
      } else {
        message = 'Login gagal';
        status = false;
      }
    } catch (e) {
      message = 'Terjadi kesalahan ($e)';
      status = false;
    }
    Get.rawSnackbar(message: message);
    return status;
  }

  Future<bool> register(
    String email,
    String password,
    String displayName,
  ) async {
    String message;
    bool success;
    var recordUser = User(
      email: email,
      password: password,
      role: 'guest',
      displayName: displayName,
    );
    try {
      DatabaseHelper().insert(
        'users',
        recordUser.toJson(),
      );
      message = 'Register berhasil';
      success = true;
      _user.value = recordUser;
    } catch (e) {
      message = 'Register gagal';
      success = false;
    }
    Get.rawSnackbar(message: message);
    return success;
  }

  void refreshAuth() async {
    final users = await _database.query(
      'users',
      where: 'id = ?',
      whereArgs: [user.id],
      columns: ['id', 'displayName', 'email', 'role'],
    );
    _user.value = User.fromJson(users.first);
  }
}
