import 'package:flutter/material.dart';
import 'package:app/battery_potimizer/main.dart';

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
