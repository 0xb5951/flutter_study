import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/profile_icon.dart';
import 'package:app/model/item.dart';
import 'package:app/repository.dart';

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  // late List<Item> _itemList;
  // late int _currentPage = 1;
  // Object? _error;
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // 投稿内容を取得する
    // _loadItemList(1);
  }

  // Future<void> _loadItemList(int page) async {
  //   // then内は非同期処理になる。ここの内容は飛ばして次を実行
  //   await QiitaRepository().getItemList(page: page).then((itemList) {
  //     // ステートを更新する
  //     setState(() {
  //       print("loadItem");
  //       print("${_itemList}");
  //       if (page == 1) {
  //         _itemList = itemList;
  //       } else {
  //         _itemList.addAll(itemList);
  //       }
  //       _currentPage = page;
  //     });
  //   }).catchError((e) {
  //     setState(() {
  //       _error = e;
  //     });
  //   }).whenComplete(() {
  //     // 最後に必ず実行される
  //     // finallryと一緒
  //     _isLoading = false;
  //   });
  //   _isLoading = true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qiita App'), actions: [
        FutureBuilder(
            // 非同期処理
            future: QiitaRepository().getAuthenticatedUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final Widget icon = snapshot.hasData
                  ? UserProfileIcon(
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
                    PopupMenuItem<String>(
                      value: 'profile',
                      child: Text(snapshot.data.profileImageUrl),
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
      body: FutureProvider<List<Item>>(
        // 渡すデータ
        create: (context) async => await QiitaRepository().getItemList(page: 1),
        initialData: [],
        child: _ItemListView(),
      ),
      // body: Placeholder(),
    );
  }

  // Widget _buildBody() {
  // _loadItemList(1);

  // if (_error != '') {
  //   return Center(
  //     child: Row(children: [
  //       Text(_error.toString()),
  //     ]),
  //   );
  // }

  //   final isItemListIsNotEmpty = _itemList!.isNotEmpty ?? false;
  //   if (isItemListIsNotEmpty) {
  //     return _ItemListView(itemList: _itemList);
  //   }

  //   // return const Center(
  //   //   child: CircularProgressIndicator(),
  //   // );
  //   return const Center(
  //     child: Placeholder(),
  //   );
  // }
}

class _ItemListView extends StatelessWidget {
  // final List<Item> itemList;
  // final Function(Item item) onTapItem;
  // final Function(User user) onTapUser;
  // final Function() onScrollEnd;

  const _ItemListView({
    Key? key,
    // required this.itemList,
    // required this.onTapItem,
    // required this.onTapUser,
    // required this.onScrollEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemList = Provider.of<List<Item>>(context);

    return ListView.separated(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final Item item = itemList[index];
        return InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              key: ValueKey<String>(item.id),
              leading: GestureDetector(
                child: UserProfileIcon(
                  size: 48,
                  profileImageUrl: item.user.profileImageUrl,
                ),
              ),
              title: Text(item.title),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      item.user.id,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1);
      },
    );
  }
}
