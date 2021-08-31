import 'package:app/signIn/main.dart';
import 'package:flutter/material.dart';

// ヘッダー要素をまとめたクラス
class Header extends StatelessWidget {
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
        onPressed: () {
          Navigator.of(context).pop();
        },
        // 真ん中のアイコンだけ
        child: const Icon(
          Icons.chevron_left,
          color: kIconColor,
        ));
  }
}
