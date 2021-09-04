import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as sp;

class QiitaRepository {
  final clientID = 'XXX'; // 登録したアプリケーションの ClientID を設定する
  final clientSecret = 'YYY'; // 登録したアプリケーションの ClientSecret を設定する
  final keyAccessToken = 'qiita/accessToken';

  String createAuthorizeUrl(String state) {
    const scope = 'read_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  }

  // 内部で非同期処理を行うからFutureクラスつけている。
  // 戻り値の型は<>に書いてある
  // qiitaのアクセストークンを取得してくる
  Future<String> createAccessTokenFromCallbackUri(
    Uri uri,
    String expectedState,
  ) async {
    final String? _state = uri.queryParameters['state'];
    final String? _code = uri.queryParameters['code'];

    // 予想されているState以外は逃がす
    if (expectedState != _state) {
      throw Exception('The state is different from expectedState.');
    }
    final response = await http.post(
      Uri.parse('https://qiita.com/api/v2/access_tokens'),
      headers: {'content-type': 'application/json'},
      body: convert.jsonEncode({
        'client_id': clientID,
        'client_secret': clientSecret,
        'code': _code,
      }),
    );
    final body = convert.jsonDecode(response.body);
    final accessToken = body['token'];

    return accessToken;
  }

  Future<void> saveAccessToken(String accessToken) async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();
    // keyAccessTokenという名前でaccessTokenをローカルに保存する
    await prefs.setString(keyAccessToken, accessToken);
  }
}
