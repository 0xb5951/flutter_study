import 'package:flutter/material.dart';
import 'package:app/battery_potimizer/main.dart';
import 'dart:math'; // インジケータの実装に使う

class BatteryLevelIndicator extends StatelessWidget {
  const BatteryLevelIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const percentage = 0.7;
    const size = 164.0;

    return CustomPaint(
      painter: _BatteryLevelIndicatorPainter(
        // こっちは周りの線だけ
        percentage: percentage,
        textCircleRadius: size * 0.5,
      ),
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Material(
          borderRadius: BorderRadius.circular(size * 0.5),
          color: Colors.white,
          elevation: bElevation, // ここが周りの円を描画してる
          child: Container(
            // こっちで真ん中の円と、パーセンテージを描画する
            height: size,
            width: size,
            child: Center(
              // Containerの中心に文字を持ってくる
              child: Text(
                "${percentage * 100}%",
                style: TextStyle(color: bColorPink, fontSize: 48),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 円周りの線だけを担当
class _BatteryLevelIndicatorPainter extends CustomPainter {
  final double percentage; // バッテリーレベルの割合(0 ~ 1)
  final double textCircleRadius; // 内側に表示される白丸の半径

  _BatteryLevelIndicatorPainter({
    required this.percentage,
    required this.textCircleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 1; i < (360 * percentage); i += 5) {
      final per = i / 360.0;
      // 割合（0~1.0）からグラデーション色に変換
      final color = ColorTween(
        begin: bColorIndicatorBegin,
        end: bColorIndicatorEnd,
      ).lerp(per)!;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      const spaceLen = 16; // 円とゲージ間の長さ
      const lineLen = 24; // ゲージの長さ
      final angle = (2 * pi * per) - (pi / 2); // 0時方向から開始するため-90度ずらす

      // 円の中心座標
      // 円の周りに線を描画するので、こうしてある
      final offset0 = Offset(size.width * 0.5, size.height * 0.5);

      // 原点から線の開始地点までを指定
      // ここから線を引き始める
      final offset1 = offset0.translate(
        (textCircleRadius + spaceLen) * cos(angle), // 真ん中の丸+線の書き始め距離
        (textCircleRadius + spaceLen) * sin(angle),
      );
      // 線の書き始めから終わりまでを指定
      final offset2 = offset1.translate(
        lineLen * cos(angle), // 線の長さ分だけを指定
        lineLen * sin(angle),
      );

      canvas.drawLine(offset1, offset2, paint);
    }
  }

  @override
  bool shouldRepaint(_BatteryLevelIndicatorPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_BatteryLevelIndicatorPainter oldDelegate) =>
      false;
}
