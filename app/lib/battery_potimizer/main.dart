import 'package:flutter/material.dart';
import 'dart:math'; // インジケータの実装に使う

const kColorPurple = Color(0xFF8337EC);
const kColorPink = Color(0xFFFF006F);
const kColorIndicatorBegin = kColorPink;
const kColorIndicatorEnd = kColorPurple;
const kColorTitle = Color(0xFF616161);
const kColorText = Color(0xFF9E9E9E);
const kElevation = 4.0;

// ignore: use_key_in_widget_constructors
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
              OptimizerButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class OptimizerButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
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
  final String title;

  const _OptimizerButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(title));
  }
}
