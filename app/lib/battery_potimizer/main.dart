import 'package:flutter/material.dart';
import 'dart:math'; // インジケータの実装に使う

const bColorPurple = Color(0xFF8337EC);
const bColorPink = Color(0xFFFF006F);
const bColorIndicatorBegin = bColorPink;
const bColorIndicatorEnd = bColorPurple;
const bColorTitle = Color(0xFF616161);
const bColorText = Color(0xFF9E9E9E);
const bElevation = 4.0;

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
              const OptimizerButtons(),
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
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(color: bColorTitle, fontSize: 12),
        ));
  }
}
