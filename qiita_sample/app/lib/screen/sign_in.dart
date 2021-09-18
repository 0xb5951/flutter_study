import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:uni_links/uni_links.dart' as uni_links;

import 'package:app/repository.dart';
import 'package:app/screen/item_list.dart';
import 'package:app/component/url_component.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final QiitaRepository repository = QiitaRepository();
  final UrlComponent urlComponent = UrlComponent();

  late String _state;
  late StreamSubscription? _subscription;

  @override
  void initState() {
    // これは必須
    super.initState();
    _state = urlComponent.randomString(40);
    // uriLinkStreamをlistenしている。
    // これに反応があったら、uriを取得し、以下を実行している。
    // webページから戻ってきたときに呼ばれる。
    // 今回はログインページを押して、戻ってきたときに実行される。
    // 戻ってきたタイミングでStateが初期化されるので、ここでOK
    _subscription = uni_links.uriLinkStream.listen((Uri? uri) {
      if (uri!.path == '/oauth/authorize/callback') {
        _onAuthorizeCallbackIsCalled(uri);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Steamの購読を停止
    _subscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Expanded(
                flex: 7,
                child: _Title(),
              ), // 真ん中のタイトル
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    // Containerの上にPaddingでも、Container自体にmargin入れても変わらない
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextButton(
                      onPressed: _signInButtonIsPressed,
                      child: Text(
                        'Qiita ログイン',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ),
                  ),
                ),
              ), // ログインボタン
              const Expanded(
                flex: 2,
                child: _Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Qiitaのログイン画面を開く
  void _signInButtonIsPressed() {
    // launchには開きたいURLを渡す
    url_launcher.launch(repository.createAuthorizeUrl(_state));
  }

  // 認証が通ったら、ItemListScreenに遷移する
  void _onAuthorizeCallbackIsCalled(Uri uri) async {
    // ログインボタン押して戻ってきた時に対応している
    url_launcher.closeWebView();

    // アクセストークンを取得して、ローカルに保存しておく
    final accessToken =
        await repository.createAccessTokenFromCallbackUri(uri, _state);
    await repository.saveAccessToken(accessToken);

    // 一方通行の画面遷移。元の画面には戻れない
    // ItemListScreenに遷移
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => ItemListScreen()),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Qiita App',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Qiitaクライアントアプリ',
            style: TextStyle(color: Colors.grey[200]),
          ),
          Text(
            'powered by Flutter',
            style: TextStyle(color: Colors.grey[200]),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Ver. 1.0.0',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'OSS Licenses',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
