import 'package:flutter/material.dart';
import 'package:app/battery_potimizer/main.dart';

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
