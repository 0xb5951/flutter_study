class QiitaRepository {
  final clientID = 'XXX'; // 登録したアプリケーションの ClientID を設定する
  final clientSecret = 'YYY'; // 登録したアプリケーションの ClientSecret を設定する
  final keyAccessToken = 'qiita/accessToken';

  String createAuthorizeUrl(String state) {
    const scope = 'read_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  }
}
