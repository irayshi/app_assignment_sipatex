import 'package:app_assignment_sipatex/app/data/services/database_service.dart';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final _user = Rx<User?>(null);
  User get user => _user.value!;

  Future<bool> login(String email, String password) async {
    final users = await DatabaseService.to.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (users.isNotEmpty) {
      await refreshAuth(users.first['id'] as int);
    }
    return users.isNotEmpty;
  }

  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    final id = await DatabaseService.to.insert(
      'users',
      User(
        email: email,
        password: password,
        role: 'guest',
        displayName: displayName,
      ).toJson(),
    );
    await refreshAuth(id);
  }

  Future<void> refreshAuth(int id) async {
    final users = await DatabaseService.to.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      columns: ['id', 'displayName', 'email', 'role'],
    );
    _user.value = User.fromJson(users.first);
  }
}
