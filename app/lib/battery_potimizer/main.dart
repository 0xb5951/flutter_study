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
              const AppList(),
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

// 要素間の線を書く
class _HorizontalBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16), // これの有無による差がわからない
      color: Colors.grey[200],
    );
  }
}

// 一つのアプリ要素
class _AppRow extends StatelessWidget {
  final Icon icon;
  final double iconSize = 20;
  final String title;
  final String percentage;

  const _AppRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: bColorText),
      ),
      trailing: Text(
        percentage,
        style: const TextStyle(color: bColorText),
      ),
    );
  }
}

class AppList extends StatelessWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipOval(
            child: Container(
              color: bColorPurple, // 背景を指定
              child: Icon(
                // 背景と組み合わせることで独自のアイコンにする
                Icons.apps,
                color: Colors.white,
              ),
            ),
          ),
          title: const Text(
            'Apps Drainage',
            style: TextStyle(color: bColorTitle),
          ),
          subtitle: const Text(
            'Show the most draining energy application',
            style: TextStyle(color: bColorText),
          ),
        ),
        Material(
          // この役割がイマイチ分からない
          color: Colors.white, // これなしだと背景は黒になる。多分テーマの色？
          elevation: bElevation,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              const _AppRow(
                icon: Icon(Icons.sms, color: Colors.indigo),
                title: 'SMSApp',
                percentage: '75%',
              ),
              _HorizontalBorder(),
              const _AppRow(
                icon: Icon(Icons.live_tv, color: Colors.red),
                title: 'MovieApp',
                percentage: '60%',
              ),
              _HorizontalBorder(),
              const _AppRow(
                icon: Icon(Icons.place, color: Colors.green),
                title: 'MapApp',
                percentage: '35%',
              ),
              _HorizontalBorder(),
              const _AppRow(
                icon: Icon(Icons.local_grocery_store, color: Colors.orange),
                title: 'ShoppingApp',
                percentage: '35%',
              ),
              _HorizontalBorder(),
              const _AppRow(
                icon: Icon(Icons.train, color: Colors.black),
                title: 'TrainApp',
                percentage: '15%',
              ),
            ],
          ),
        )
      ],
    );
  }

  void buildColors() => Colors;
}
