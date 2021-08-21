import 'package:flutter/material.dart';

const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Color(0xFF19283D);
const Color kTextColorPrimary = Color(0xFFECEFF1);
const Color kTextColorSecondary = Color(0xFFB0BEC5);
const Color kButtonColorPrimary = Color(0xFFECEFF1);
const Color kButtonTextColorPrimary = Color(0xFF455A64);
const Color kIconColor = Color(0xFF455A64);

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
              _Header(),
              _SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// ヘッダー要素をまとめたクラス
class _Header extends StatelessWidget {
  final double height = 320; // これで全体の要素を調整する

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    // ignore: sized_box_for_whitespace
    return Container(
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          _HeaderBackground(height: height),
          _HeaderCircle(height: height),
          const Padding(
            padding: EdgeInsets.only(top: 128),
            child: _HeaderTitle(),
          ),
          // 戻るボタンは左上に表示
          const Positioned(
            top: 16,
            left: 0,
            child: _HeaderBackButton(),
          ),
        ],
      ),
    );
  }
}

// オレンジ色の背景
class _HeaderBackground extends StatelessWidget {
  final double height;

  const _HeaderBackground({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HeaderBackgroundClipper(),
      // 背景の赤い要素
      child: Container(
        width: double.infinity, // 要素のサイズを最大限まで大きくする
        height: height,
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

class _HeaderCirclePainter extends CustomPainter {
  // 描画を定義する
  // このsizeはCustomPaintで設定したsizeか、childの要素を参照する。
  // 今回はchildで設定しているContainer
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    // 場所、半径、どの様に描画するか
    canvas.drawCircle(Offset(size.width * 0.20, size.height * 0.4), 12, paint);
    canvas.drawCircle(Offset(size.width * 0.80, size.height * 0.2), 12, paint);
  }

  // 再描画のタイミングで再生成するか
  @override
  bool shouldRepaint(_HeaderCirclePainter oldDelegate) => false;
}

// ２つの小さい丸
class _HeaderCircle extends StatelessWidget {
  final double height;

  const _HeaderCircle({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeaderCirclePainter(),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        height: height,
      ),
    );
  }
}

// ヘッダー真ん中のタイトル
class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Welcome",
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Sign in to continue",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

// 左上の戻るボタン
class _HeaderBackButton extends StatelessWidget {
  const _HeaderBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        // 周りの白い縁の部分
        style: TextButton.styleFrom(
          primary: kButtonColorPrimary,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(
            side: BorderSide(color: kButtonColorPrimary),
          ),
        ),
        onPressed: () {},
        // 真ん中のアイコンだけ
        child: const Icon(
          Icons.chevron_left,
          color: kIconColor,
        ));
  }
}

// フォーム要素
// フォーム部分を使いまわして実装するためのクラス
class _CustomTextFrom extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const _CustomTextFrom({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},
      obscureText: obscureText, // 入力内容を隠すか
      decoration: InputDecoration(
        labelText: labelText, // フォームの右上に表示するラベル
        hintText: hintText, // プレースホルダー
        hintStyle: const TextStyle(color: kTextColorSecondary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          // 選択していないときのフォームスタイル
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(color: kTextColorSecondary), // ラベルを上に表示するか？
        ),
        focusedBorder: OutlineInputBorder(
          // 選択しているときのフォームスタイル
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: kAccentColor,
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _CustomTextFrom(
          labelText: 'Email',
          hintText: 'your email address goes here',
          obscureText: false,
        ),
        SizedBox(
          height: 48,
        ),
        const _CustomTextFrom(
          labelText: 'Password',
          hintText: 'your password goes here',
          obscureText: true,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Forgot Password?",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(
          height: 48,
        ),
        // ポストするボタン
        Container(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: kButtonTextColorPrimary,
              backgroundColor: kBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 16), // ボタン内の縦余白
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Sign in",
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kButtonColorPrimary, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'OR',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(height: 16),
        Text(
          'Connect with',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorPrimary),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            Container(
              color: kTextColorSecondary,
              width: 1,
              height: 16,
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
