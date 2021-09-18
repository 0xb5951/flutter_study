import 'package:flutter_test/flutter_test.dart';

// テスト対象
import 'package:app/component/date_component.dart';

void main() {
  DateComponent dateComponent = DateComponent();

  group('setUpDataFormat()', () {
    test('想定した形になっているか', () {
      final DateTime date = DateTime(2021, DateTime.may, 1, 9, 00);
      expect(dateComponent.setUpDataFormat(date), '5/1 9:00');
    });
  });
}
