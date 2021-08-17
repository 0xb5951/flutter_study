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
      clipper: _HeaderBackgroundClipper(),
      // 背景の赤い要素
      child: Container(
        width: double.infinity, // 要素のサイズを最大限まで大きくする
        height: 300,
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

class _HeaderBackgroundClipper extends CustomClipper<Path> {
  // 切り抜く形
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.55,
        size.height, // コントロールポイント
        size.width,
        size.height * 0.6 // ゴール
        );
    path.lineTo(size.width, 0);
    return path;
  }

  // オブジェクトを更新したときに、再生成するか
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
