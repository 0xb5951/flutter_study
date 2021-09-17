import 'package:app/model/tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Qiitaの戻り値からTagオブジェクトに変換できるか', () {
      final expectedJson = {
        "name": "qiita",
        "versions": ["0.0.1"]
      };

      final tag = Tag.fromJson(expectedJson);

      expect(tag.name, 'qiita');
      expect(tag.versions, ['0.0.1']);
    });
  });
}
