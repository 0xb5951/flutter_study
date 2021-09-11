import 'package:flutter/material.dart';

import 'package:app/component/date_component.dart';

// 一つの投稿要素を生成する
class PostedItem extends StatelessWidget {
  final String title;
  final String userName;
  final DateTime postedDate;
  // あとプロフィールの画像もある
  final String profileUrl;

  static DateComponent dateComponent = DateComponent();

  const PostedItem({
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
            Text(dateComponent.setUpDataFormat(postedDate)),
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
      const Divider(
        height: 1,
        color: Colors.black,
      )
    ]);
  }
}
