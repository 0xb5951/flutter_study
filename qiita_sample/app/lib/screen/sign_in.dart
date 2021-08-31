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
              SizedBox(
                height: 260,
              ),
              _Title(), // 真ん中のタイトル
              SizedBox(
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32), // ページの横からをpaddingする。数字を少なくすれば長くなる
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Qiita ログイン',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32)),
                  ),
                ),
              ), // ログインボタン
              SizedBox(
                height: 80,
              ),
              _Footer(),
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
        children: [
          Text(
            'Qiita App',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          SizedBox(
            height: 10,
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
      children: [
        Text(
          'Ver. 1.0.0',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'OSS Licenses',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
