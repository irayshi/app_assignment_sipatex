import 'package:app_assignment_sipatex/app/routes.dart';
import 'package:app_assignment_sipatex/providers/auth_provider.dart';
import 'package:get/get.dart';

class AuthService {
  static AuthService get to => Get.find();
  final AuthProvider _authProvider;
  AuthService({required AuthProvider authProvider})
    : _authProvider = authProvider;

  int? userId;

  Future<void> loadSession() async {
    userId = await _authProvider.getCurrentUserId();
  }

  Future<void> login({required String email, required String password}) async {
    userId = await _authProvider.login(email: email, password: password);
    await _authProvider.saveSession(userId: userId!, isLoggedIn: true);
    Get.offAllNamed(Routes.home);
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    userId = await _authProvider.register(
      email: email,
      password: password,
      name: name,
    );
    await _authProvider.saveSession(userId: userId!, isLoggedIn: true);
    Get.offAllNamed(Routes.home);
  }

  Future<void> logout() async {
    await _authProvider.saveSession(userId: userId!, isLoggedIn: false);
    userId = null;
    Get.offAllNamed(Routes.login);
  }
}
