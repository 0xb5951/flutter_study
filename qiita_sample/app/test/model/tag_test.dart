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

    test('複数件あったときに、正しく変換できるか', () {
      final expectedJson = {
        "tags": [
          {
            "name": "qiita",
            "versions": ["0.0.1"],
          },
          {
            "name": "sample",
            "versions": ["0.0.1"],
          },
        ],
      };

      final tagList = (expectedJson['tags'] as List<dynamic>).map((tagJson) {
        return Tag.fromJson(tagJson);
      }).toList();

      expect(tagList.length, 2);
      expect(tagList[0].name, "qiita");
      expect(tagList[0].versions, ["0.0.1"]);
      expect(tagList[1].name, "sample");
      expect(tagList[1].versions, ["0.0.1"]);
    });
  });
}
