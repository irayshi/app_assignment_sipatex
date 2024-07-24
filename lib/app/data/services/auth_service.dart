import 'package:app_assignment_sipatex/app/data/databases/database_helper.dart';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  late Database _database;
  final _user = Rx<User?>(null);
  User get user => _user.value!;

  @override
  void onInit() async {
    _database = await DatabaseHelper().database;
    super.onInit();
  }

  Future<bool> login(String email, String password) async {
    final users = await _database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (users.isNotEmpty) {
      _user.value = User.fromJson(users.first);
    }
    return users.isNotEmpty;
  }

  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    final recordUser = User(
      email: email,
      password: password,
      role: 'guest',
      displayName: displayName,
    );
    recordUser.id = await _database.insert(
      'users',
      recordUser.toJson(),
    );
    _user.value = recordUser;
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
