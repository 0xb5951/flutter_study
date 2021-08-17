import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AdminMobilePage extends StatefulWidget {
  @override
  _AdminMobilePageState createState() => _AdminMobilePageState();
}

class _AdminMobilePageState extends State<AdminMobilePage> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Mobile"),
      ),
      body: Row(
        children: [
          SideBar(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            // このExpandedがないとすべて表示できない
            child: PostList(),
          ),
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SideBar extends StatefulWidget {
  @override
  _SideBar createState() => _SideBar();
}

class _SideBar extends State<SideBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      // 現在選択されている要素のインデックス
      selectedIndex: selectedIndex,
      // 要素がタップされたときに呼び出される
      onDestinationSelected: (index) {
        selectedIndex = index;
      },
      // ignore: prefer_const_literals_to_create_immutables
      destinations: [
        const NavigationRailDestination(
            icon: Icon(Icons.people), label: Text("People")),
        const NavigationRailDestination(
            icon: Icon(Icons.thumbs_up_down), label: Text("Thunb up down")),
        const NavigationRailDestination(
            icon: Icon(Icons.face), label: Text("Face")),
        const NavigationRailDestination(
            icon: Icon(Icons.bookmark), label: Text("bookmark")),
      ],
    );
  }
}

// ignore: use_key_in_widget_constructors
class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 画面上部に対するpadding
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        // 要素を縦に並べたいのでcolumn
        mainAxisSize: MainAxisSize.max,
        children: [
          _PostsHeader(),
          Expanded(
            // ListViewで要素が増えても無限スクロールにしている
            child: ListView(
              children: [
                _PostGreen(),
                _PostRed(),
                _PostGreen(),
                _PostRed(),
                _PostGreen(),
                _PostRed(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // 要素を横に並べたいのでrow
      children: [
        Expanded(
          flex: 1, // このExpandedが占める比率。複数Expandedがある時に使う
          child: ListTile(
            leading: ClipOval(
              child: Container(
                //このコンテナだけだと、四角いアイコンになる
                color: Colors.grey[300], // []内は色の濃さ。999までで高いほど黒くなる
                width: 48,
                height: 48,
                child: Icon(
                  //要素の真ん中にストレージアイコンが表示される
                  Icons.storage,
                  color: Colors.grey[800], // アイコンの色も指定できる
                ),
              ),
            ),
            title: const Text('Posts'),
            subtitle: const Text('20 Posts'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            leading: ClipOval(
              child: Container(
                color: Colors.grey[300],
                width: 48,
                height: 48,
                child: Icon(
                  Icons.style,
                  color: Colors.grey[800],
                ),
              ),
            ),
            title: const Text('All Types'),
            subtitle: const Text(''),
          ),
        ),
      ],
    );
  }
}

// このクラスを作ることで、UI要素を使いまわしている
class _Post extends StatelessWidget {
  final String name;
  final String message;
  final String textReason;
  final Color colorPrimary;
  final Color colorPositive;
  final String textPositive;
  final Color colorNegative;
  final String textNegative;

  // このクラスで使う引数を定義
  const _Post({
    Key? key,
    required this.name,
    required this.message,
    required this.textReason,
    required this.colorPrimary,
    required this.colorPositive,
    required this.textPositive,
    required this.colorNegative,
    required this.textNegative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // それぞれのカードの余白を調整する
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      // ここから下で一つのカード要素を表しているが、長くてイマイチ分からない
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          // カード要素の子要素
          children: [
            // カードのアイコンと上部のテキスト２つ
            ListTile(
              leading: ClipOval(
                child: Container(
                  color: colorPrimary,
                  width: 48, // アイコンのサイズ
                  height: 48,
                  child: Center(
                    // アイコンの中の文字。名前の先頭一文字を抜き出している
                    child: Text(
                      name.substring(0, 1),
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              title: Text(name),
              subtitle: const Text('2 min ago'),
            ),
            // 真ん中の円とメッセージ部分
            Container(
              // ここも要素右のpadding.sizedboxとの使い分けがわからない
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // メッセージ部分の左paddingを行っている
                  const SizedBox(width: 72),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      // 要素のボーダーを太くして色をつけている
                      border: Border.all(color: colorPrimary, width: 4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // 丸図形とテキストの間のpadding
                  const SizedBox(width: 8),
                  Flexible(child: Text(message)),
                ],
              ),
            ),
            // 下のtextReasonとボタン群
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // textReason要素
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: colorPrimary, width: 2),
                      ),
                    ),
                    child: Text(
                      textReason,
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  // textReasonとネガティブボタンの間padding
                  const SizedBox(width: 24),
                  // ここにExpandedすることでtextReasonの長さに左右されなくしている
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: colorNegative,
                      ),
                      onPressed: () {},
                      child: Text(textNegative),
                    ),
                  ),
                  // ボタン間のpadding
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: colorPositive,
                        backgroundColor: colorPositive.withOpacity(0.2),
                      ),
                      onPressed: () {},
                      child: Text(textPositive),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Post(
      name: 'Name',
      message: 'message',
      textReason: 'textReason',
      colorPrimary: Colors.greenAccent, // アイコンなどの色
      colorPositive: Colors.greenAccent,
      textPositive: 'Positive',
      colorNegative: Colors.blueAccent,
      textNegative: 'Negative',
    );
  }
}

class _PostRed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Post(
      name: 'Namaga Tema',
      message: 'Not recomended for publication.',
      textReason: 'Pending Reason',
      colorPrimary: Colors.deepOrangeAccent,
      colorPositive: Colors.blueAccent,
      textPositive: 'Publish',
      colorNegative: Colors.deepOrangeAccent,
      textNegative: 'Decline',
    );
  }
}
