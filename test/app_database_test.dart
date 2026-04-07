import 'package:app_assignment_sipatex/app/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('berhasil membuat database', () async {
    try {
      final db = await AppDatabase().init(test: true);
      await db.query('users');
    } catch (e) {
      expect(true, false);
    }
  });
}
