import 'package:flutter/material.dart';
import 'dart:math'; // インジケータの実装に使う

const bColorPurple = Color(0xFF8337EC);
const bColorPink = Color(0xFFFF006F);
const bColorIndicatorBegin = bColorPink;
const bColorIndicatorEnd = bColorPurple;
const bColorTitle = Color(0xFF616161);
const bColorText = Color(0xFF9E9E9E);
const bElevation = 4.0;

// ignore:
class BatteryOptimizerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Battery Optimizer'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const OptimizerButtons(),
              const BatteryLevelIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class OptimizerButtons extends StatelessWidget {
  const OptimizerButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // これで横スクロールする
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const _OptimizerButton(title: 'Battery Optimizer'),
            const SizedBox(width: 16),
            const _OptimizerButton(title: 'Connection Optimizer'),
            const SizedBox(width: 16),
            const _OptimizerButton(title: 'Memory Optimizer'),
            const SizedBox(width: 16),
            const _OptimizerButton(title: 'Storage Optimizer'),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _OptimizerButton extends StatelessWidget {
  final String title; // ボタンに表示する文字

  const _OptimizerButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var styleFrom = ElevatedButton.styleFrom(
      primary: Colors.white, // ボタンの背景
      padding: const EdgeInsets.symmetric(horizontal: 16), // これがどこに聞いているか謎
      shape: RoundedRectangleBorder(
        // ボタンの周りの形
        borderRadius: BorderRadius.circular(16),
      ),
    );
    return ElevatedButton(
        style: styleFrom,
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(color: bColorTitle, fontSize: 12),
        ));
  }
}

class _BatteryLevelIndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final c = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(c, 80, paint);
  }

  @override
  bool shouldRepaint(_BatteryLevelIndicatorPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_BatteryLevelIndicatorPainter oldDelegate) =>
      false;
}

class BatteryLevelIndicator extends StatelessWidget {
  const BatteryLevelIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BatteryLevelIndicatorPainter(),
      size: Size(400, 400),
    );
  }
}
