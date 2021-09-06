import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Qiita App'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // 押したら、自分のプロフィールに遷移
              },
              // あとでログインユーザのプロフィールに遷移
              icon: const Icon(Icons.local_movies),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _PostedItem(
                  title: 'title',
                  userName: 'user_name',
                  postedDate: DateTime.now(),
                  profileUrl:
                      'https://avatars.githubusercontent.com/u/33741792?s=88&u=fdfb8ec0ee5ad4ea0f7a4b2c7f0a6c7ede6581a8&v=4',
                ),
                _PostedItem(
                  title: 'title',
                  userName: 'user_name',
                  postedDate: DateTime.now(),
                  profileUrl:
                      'https://s3-ap-northeast-1.amazonaws.com/qiita-image-store/0/1075243/04b9772c31531b440303a986812c5795ed587b23/large.png?1612246089',
                ),
              ],
            ),
          ),
        ));
  }

  Now() {}
}

// 一つの投稿要素を生成する
class _PostedItem extends StatelessWidget {
  final String title;
  final String userName;
  final DateTime postedDate;
  // あとプロフィールの画像もある
  final String profileUrl;

  const _PostedItem({
    Key? key,
    required this.title,
    required this.userName,
    required this.postedDate,
    required this.profileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: () {}, // 押したら、その投稿に移動する
        title: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(profileUrl),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
          children: [
            Text(userName),
            Text(setUpDataFormat(postedDate)),
          ],
        ),
        trailing: Container(
          height: 24,
          width: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '5',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Divider(
        height: 1,
        color: Colors.black,
      )
    ]);
  }

  String setUpDataFormat(DateTime date) {
    intl.DateFormat outputformat = intl.DateFormat('M/d k:m');
    return outputformat.format(date);
  }
}
