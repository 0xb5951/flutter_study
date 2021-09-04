import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import 'package:app/repository.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final QiitaRepository repository = QiitaRepository();

  late String _state;

  @override
  void initState() {
    // これは必須
    super.initState();

    _state = _randomString(40);
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

  void _signInButtonIsPressed() {
    // launchには開きたいURLを渡す
    launch(repository.createAuthorizeUrl(_state));
  }

// lengthで指定された長さのランダムな文字列を生成する
  String _randomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = math.Random.secure();
    final codeUnit = List.generate(length, (index) {
      // charsの文字列からランダムなインデックスを指定する
      final n = rand.nextInt(chars.length);
      // 指定したインデックスの文字列をUTF-16のコードに変換して返す。ex. 0x41 = A
      return chars.codeUnitAt(n);
    });
    // codeUnitにはUTF-16化した文字コードのリストが入っている
    return String.fromCharCodes(codeUnit);
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
