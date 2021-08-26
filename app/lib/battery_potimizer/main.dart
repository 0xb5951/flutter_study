import 'package:flutter/material.dart';
import 'package:app/battery_potimizer/app_list.dart';
import 'package:app/battery_potimizer/optimizer_buttons.dart';
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
              const AppList(),
            ],
          ),
        ),
      ),
    );
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
