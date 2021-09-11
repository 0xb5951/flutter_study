import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mock;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// テスト対象
import 'package:app/repository.dart';

// テスト実行部
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  QiitaRepository repository;

  // 最初に外部リソースに依存するhttp通信クライアントをモック化
  // setUpはいらない？
  repository = QiitaRepository();
  String? clientID = repository.clientID;

  // createAuthorizeUrlのテスト
  group('createAuthorizeUrl()', () {
    test('stateがない場合', () {
      expect(repository.createAuthorizeUrl(''),
          'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=read_qiita&state=');
    });

    test('stateがある場合', () {
      const String state = 'test';
      expect(repository.createAuthorizeUrl(state),
          'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=read_qiita&state=test');
    });
  });
}
