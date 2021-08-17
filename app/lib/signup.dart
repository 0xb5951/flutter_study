import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SignUpSignInWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // この中にヘッダー、フォーム、フッダーを書いていく
              _HeaderBackground(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // 背景の赤い要素
      child: Container(
        width: double.infinity, // 要素のサイズを最大限まで大きくする
        height: 400,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                // 左上から右下にかけてグラデーションを作る
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
              Color(0xFFFD9766),
              Color(0xFFFF7362),
            ],
                stops: [
              0,
              1
            ])),
      ),
    );
  }
}
