import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                      onPressed: () {},
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
