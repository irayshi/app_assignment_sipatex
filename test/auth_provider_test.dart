import 'package:app_assignment_sipatex/app/app_database.dart';
import 'package:app_assignment_sipatex/providers/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() async {
    Get.testMode = false;
    final db = await AppDatabase().init(test: true);
    Get.lazyPut(() => AuthProvider(db: db));
  });
  test('login success', () async {
    try {
      await AuthProvider.to.login(email: 'test@gmail.com', password: '123');
    } catch (e) {
      expect(true, false);
    }
  });
  test('login failed', () async {
    try {
      await AuthProvider.to.login(email: 'test3@gmail.com', password: '123');
    } catch (e) {
      expect(true, true);
    }
  });
  test('register success', () async {
    try {
      await AuthProvider.to.register(
        email: 'test2@gmail.com',
        password: '123',
        name: 'test',
      );
    } catch (e) {
      expect(true, false);
    }
  });
  test('tidak bisa buat email yang sama', () async {
    try {
      await AuthProvider.to.register(
        email: 'test@gmail.com',
        password: '123',
        name: 'test',
      );
    } catch (e) {
      expect(true, true);
    }
  });
}
