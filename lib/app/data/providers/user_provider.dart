import 'package:app_assignment_sipatex/app/data/databases/database_helper.dart';
import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:get/get.dart';

class UserProvider extends GetxController {
  static UserProvider get to => Get.find();
  final users = <User>[].obs;

  @override
  void onInit() async {
    users.value = await _getLocal();
    super.onInit();
  }

  Future<List<User>> _getLocal() async {
    var data = await DatabaseHelper().openDB().then((db) {
      return db.query('users');
    });

    return data.map((e) => User.fromJson(e)).toList();
  }

  void delete(int id) {
    DatabaseHelper().delete('users', id);
  }

  void create(User user) {
    final data = {
      'id': user.id,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'displayName': user.displayName,
    };
    DatabaseHelper().insert('users', data);
  }

  Future<void> edit(User user) async {
    final data = {
      'id': user.id,
      'email': user.email,
      'role': user.role,
      'displayName': user.displayName,
    };
    await DatabaseHelper().edit('users', data, user.id!);
  }

  Future<bool> checkEmail(String email) {
    return DatabaseHelper().openDB().then((db) async {
      final users = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      return users.isEmpty ? false : true;
    });
  }
}
