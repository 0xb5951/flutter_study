import 'package:flutter_test/flutter_test.dart';

// テスト対象
import 'package:app/component/url_component.dart';

void main() {
  UrlComponent urlComponent = UrlComponent();

  group('randomString()', () {
    test('入力文字数が等しいか', () {
      expect(urlComponent.randomString(10).length, 10);
    });

    test('意図した文字以外が使われていないか', () {
      const String expectedValue = 'abcdefghijklmnopqrstuvwxyz0123456789';
      String generatedString = urlComponent.randomString(10);
      expect(
          generatedString.replaceAll(RegExp(r'[' + expectedValue + r']'), ''),
          '');
    });

    test('入力文字数が0のときは、何も出力されない', () {
      expect(urlComponent.randomString(0), '');
    });
  });
}
