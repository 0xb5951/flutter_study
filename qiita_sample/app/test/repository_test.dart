import 'package:app/model/item.dart';
import 'package:app/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

// モック
import './repository_test.mocks.dart';

// テスト対象
import 'package:app/repository.dart';

@GenerateMocks([http.Client])
// テスト実行部
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  late http.Client httpClient;
  late QiitaRepository repository;
  late String? clientID;
  late String? clientSecret;
  late String? keyAccessToken;

  setUp(() {
    httpClient = MockClient();
    repository = QiitaRepository();
    clientID = repository.clientID;
    clientSecret = repository.clientSecret;
    keyAccessToken = repository.keyAccessToken;
  });

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

  group('createAccessTokenFromCallbackUri()', () {
    test('想定したstateと異なる場合', () {
      final params = {'state': 'wrong_state', 'code': 'wrong_code'};
      Uri uri = Uri.https('qiita.com', 'api/v2/access_tokens', params);

      expect(repository.createAccessTokenFromCallbackUri(uri, 'correct_state'),
          throwsA(const TypeMatcher<Exception>()));
    });

    // test('test', () async {
    //   final Uri mockUrl = Uri.parse('https://qiita.com/api/v2/access_tokens');
    //   final responsePayload = convert.jsonEncode({
    //     'response_code': '200',
    //     'token': 'token',
    //   });

    //   when(httpClient.post(
    //     mockUrl,
    //     headers: {'content-type': 'application/json'},
    //     body: convert.jsonEncode({
    //       'client_id': clientID,
    //       'client_secret': clientSecret,
    //       'code': 'test',
    //     }),
    //   )).thenAnswer((_) async => http.Response(responsePayload, 200));

    //   expect(
    //       await httpClient
    //           .post(
    //         Uri.parse('https://qiita.com/api/v2/access_tokens'),
    //         headers: {'content-type': 'application/json'},
    //         body: convert.jsonEncode({
    //           'client_id': clientID,
    //           'client_secret': clientSecret,
    //           'code': 'test',
    //         }),
    //       )
    //           .then((response) {
    //         final body = convert.jsonDecode(response.body);
    //         final accessToken = body['token'];
    //         return accessToken;
    //       }),
    //       'token');
  });

  //   test('認証に失敗した時', () async {
  //     // Qiitaからのレスポンスをmock化
  //     final Uri mockUrl = Uri.parse('https://qiita.com/api/v2/access_tokens');
  //     final responsePayload = convert.jsonEncode({
  //       'response_code': '200',
  //       'token': 'token',
  //     });

  //     when(httpClient.post(
  //       mockUrl,
  //       headers: {'content-type': 'application/json'},
  //       body: convert.jsonEncode({
  //         'client_id': clientID,
  //         'client_secret': clientSecret,
  //         'code': 'test',
  //       }),
  //     )).thenAnswer((_) async => http.Response(responsePayload, 200));
  //   });
  // });

  group('Get&SaveAccessToken', () {
    test('正しく値が保存されていること', () async {
      // ignore: unnecessary_string_interpolations
      SharedPreferences.setMockInitialValues({'$keyAccessToken': 'testToken'});

      await repository.saveAccessToken('testToken');
      expect(await repository.getAccessToken(), 'testToken');
    });
  });

  // group('getItemList', () {
  //   test('ページが正しく取得できる', () async {
  //     // tokenのモックを作成
  //     // when(repository.getAccessToken()).thenAnswer((_) async => 'testToken');

  //     final accessToken = await repository.getAccessToken();
  //     // Qiitaのモックを作成
  //     final Uri mockUrl = Uri.parse('https://qiita.com/api/v2/items?page=1');
  //     final responsePayload = convert.jsonEncode({
  //       'response_code': '200',
  //       'token': 'token',
  //     });

  //     when(httpClient.post(
  //       mockUrl,
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     )).thenAnswer((_) async => http.Response(responsePayload, 200));

  //     final List listItem = await repository.getItemList();

  //     expect(listItem[0], "c686397e4a0f4f11683d");
  //   });
  // });
}
