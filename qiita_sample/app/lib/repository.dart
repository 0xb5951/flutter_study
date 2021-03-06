import 'dart:convert' as convert;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as sp;

import 'model/user.dart';
import 'package:app/model/item.dart';

class QiitaRepository {
  final clientID =
      dotenv.env['QIITA_CLIENT_ID']; // 登録したアプリケーションの ClientID を設定する
  final clientSecret =
      dotenv.env['QIITA_CLIENT_SECRET']; // 登録したアプリケーションの ClientSecret を設定する
  final keyAccessToken = 'qiita/accessToken';
  http.Client client = http.Client();

  String createAuthorizeUrl(String state) {
    const scope = 'read_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  }

  Future<User> getAuthenticatedUser() async {
    final accessToken = await getAccessToken();
    print('getAuthenticatedUser');
    print(accessToken);
    final response = await client.get(
      Uri.parse('https://qiita.com/api/v2/authenticated_user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    final body = convert.jsonDecode(response.body);
    final user = User.fromJson(body);

    return user;
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
    late String accessToken;

    // 予想されているState以外は逃がす
    if (expectedState != _state) {
      throw Exception('The state is different from expectedState.');
    }

    await client
        .post(
      Uri.parse('https://qiita.com/api/v2/access_tokens'),
      headers: {'content-type': 'application/json'},
      body: convert.jsonEncode({
        'client_id': clientID,
        'client_secret': clientSecret,
        'code': _code,
      }),
    )
        .then((response) {
      final body = convert.jsonDecode(response.body);
      accessToken = body['token'];
    }).catchError((err) {
      throw Exception(err);
    });

    return accessToken;
  }

  Future<void> saveAccessToken(String accessToken) async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();
    // keyAccessTokenという名前でaccessTokenをローカルに保存する
    await prefs.setString(keyAccessToken, accessToken);
  }

  Future<String?> getAccessToken() async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();
    // ローカルに保存した変数を取得する
    return prefs.getString(keyAccessToken);
  }

  // Qiitaの投稿を取得してくる
  Future<List<Item>> getItemList({int page = 1, QiitaItemsQuery? query}) async {
    final accessToken = await getAccessToken();
    String url = 'https://qiita.com/api/v2/items?page=$page';

    if (query != null) {
      url += '&query=${query.buildString()}';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final persedBody = convert.jsonDecode(response.body);

    // パースしたボディをList<dynamic>にキャストしている
    // それに対してmap内の処理を行ってリスト化している
    // dynamicで型をある程度指定せずに宣言できる
    final itemList = persedBody.map((item) {
      return Item.fromJson(item);
    }).toList();

    return itemList.cast<Item>() as List<Item>;
  }
}

class QiitaItemsQuery {
  late String userID;

  QiitaItemsQuery userIdEquals(String id) {
    userID = id;
    return this;
  }

  String buildString() {
    List<String> queries = [];
    queries.add('user:$userID');

    return queries.join(' ');
  }
}
