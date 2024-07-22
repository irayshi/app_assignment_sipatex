import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test variabel', () {
    test('test split', () {
      var test = 'test, test2, test3';
      expect(
        test.split(',').map((e) => e.trim()).toList(),
        equals(['test', 'test2', 'test3']),
      );
    });
    test('test join', () {
      var test = ['test', 'test2', 'test3'];
      expect(test.join(', '), equals('test, test2, test3'));
    });
  });
}
