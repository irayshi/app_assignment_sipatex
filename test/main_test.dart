import 'package:app_assignment_sipatex/providers/auth_provider.dart';
import 'package:app_assignment_sipatex/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {
  
}

void main() {
  test('hanya ada 1 objek AuthProvider', () async {
    final authProvider = AuthProvider(db: MockDatabase());
    Get.lazyPut(()=> authProvider);
    Get.lazyPut(()=> AuthService(authProvider: authProvider));
    expect(identical(authProvider, AuthProvider.to), true);
  });
}