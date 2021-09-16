import 'dart:convert' as convert;
import 'dart:io';
import 'package:app/model/tag.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as sp;
import 'package:app/model/item.dart';

import 'model/user.dart';

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
    final response = await client.get(
      Uri.parse('https://qiita.com/api/v2/authenticated_user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    final body = convert.jsonDecode(response.body);
    final user = _mapToUser(body);

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
      final accessToken = body['token'];

      return accessToken;
    }).catchError((err) {
      throw Exception(err);
    });

    return '';
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

  // ユーザオブジェクトに変換する
  User _mapToUser(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      profileImageUrl: map['profile_image_url'],
      itemsCount: map['items_count'],
      followersCount: map['followers_count'],
    );
  }

  // Qiitaの投稿を取得してくる
  Future<List<Item>> getItemList({int page = 1, QiitaItemsQuery? query}) async {
    final Future<String?> accessToken = getAccessToken();
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
      return Item(
        id: item['id'],
        title: item['title'],
        renderedBody: item['rendered_body'],
        createdAt: DateTime.parse(item['created_at']),
        likesCount: item['likes_count'],
        tags: (item['tags'] as List<dynamic>).map((tag) {
          return Tag(
            name: tag['name'],
            versions: (tag['versions'] as List<dynamic>)
                .map((v) => v as String)
                .toList(),
          );
        }).toList(),
        user: _mapToUser(item['user']),
      );
    }).toList();

    return itemList;
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
