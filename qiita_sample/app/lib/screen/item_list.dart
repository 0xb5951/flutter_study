import 'package:app/model/item.dart';
import 'package:app/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late List<Item> _itemList;
  late int _currentPage = 1;
  late Object _error;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 投稿内容を取得する
    _loadItemList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Qiita App'), actions: [
          FutureBuilder(
              // 非同期処理
              future: QiitaRepository().getAuthenticatedUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final Widget icon = snapshot.hasData
                    ? _UserProfileIcon(
                        size: 32,
                        // snapshot.dataには非同期処理で帰ってきた結果が入っている
                        // 今回はUserオブジェクトが入っている
                        profileImageUrl: snapshot.data.profileImageUrl,
                      )
                    : const Icon(Icons.person);

                // タップしたら、メニューが立ち上がるタイプのボタン
                return PopupMenuButton<String>(
                  icon: icon,
                  itemBuilder: (context) {
                    return [
                      // メニューの項目
                      const PopupMenuItem<String>(
                        value: 'profile',
                        child: Text('プロフィール'),
                      ),
                      const PopupMenuItem(
                        value: 'logout',
                        child: Text('ログアウト'),
                      ),
                    ];
                  },
                );
              })
        ]),
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

  void _loadItemList(int page) {
    // then内は非同期処理になる。ここの内容は飛ばして次を実行
    QiitaRepository().getItemList(page: page).then((itemList) {
      // ステートを更新する
      setState(() {
        if (page == 1) {
          _itemList = itemList;
        } else {
          _itemList.addAll(itemList);
        }
        _currentPage = page;
      });
    }).catchError((e) {
      setState(() {
        _error = e;
      });
    }).whenComplete(() {
      // 最後に必ず実行される
      // finallryと一緒
      _isLoading = false;
    });
    _isLoading = true;
  }
}

class _UserProfileIcon extends StatelessWidget {
  final double size;
  final String profileImageUrl;

  const _UserProfileIcon({
    Key? key,
    required this.size,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        profileImageUrl,
        width: size,
        height: size,
        // ネットワークからの取得に失敗したときに表示する
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey,
          );
        },
      ),
    );
  }
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
