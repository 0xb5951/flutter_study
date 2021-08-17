# 目的
Flutterのことを理解するために簡単なTODOアプリを作る。
基本的に以下の記事を写経する。
https://www.flutter-study.dev/todo-app/about-todo-app

上記を実装できた。
何となく肌間は掴んできたが、テストやUIの実装をもうちょっと試したい。
以下の記事をつまみながら実装する。
https://www.flutter-study.dev/create-ui/top


## 開発周り
## Emulatorの起動
Dockerコンテナ上に、Androidエミュレータも内包している。
VSCodeのremote containerにログインしたら、VSCode以外のターミナルで以下のコマンドを実行する。
```
docker exec -iu circleci flutter_todo bash -c "./run_second_startup.sh && emulator @pixel_android_31_x86_64 -gpu swiftshader_indirect" 
```

※事前にホスト側でx11の実行を許可してやる必要があるので注意。
Linuxの場合は以下のコマンドを実行
```
xhost +local:
```

### tips
- emulator起動させた直後は、重いのでちょっと待つ必要がある

## 学んだことを以下に書く
- Scaffoldでページのベースを作るところから始める
- Navigatorで画面遷移。これはページをstackに入れるイメージ
- スクロール可能なリストは、ListViewを使う。内部にwidget要素を配置する
- ただ、上記だと寂しいので、Card要素などで対象を装飾する
- StatefulWidgetは内部にState要素の更新をさせる部分と持ち、内容を書くのはState側
```
class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}
```
- 要素の内部で変更を伝えるときは、SetState()を使う。onChangeなどと組み合わせる
- main要素にRoute要素をまとめて設定しておくことができる
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new MainPage(),
        '/subpage': (BuildContext context) => new SubPage()
      },
    );
  }
}

  // 使う時 
  RaisedButton(onPressed: () => Navigator.of(context).pushNamed("/subpage"), child: new Text('Subページへ'),)
```
- 色々な要素を配置するときは、要素ごとに分けて、メイン要素内部にそれぞれ配置すればよい
- サイドバーはNavigationRail()で実現できる

## 参考になる資料

|資料名|リンク|コメント|
|--|--|--|
|Flutter実践入門 ～環境構築からAndroid/iOS/Webに広告を付けて同時にリリース!!～|https://zenn.dev/kazutxt/books/flutter_practice_introduction| Dartの基本からFlutterでデプロイするまでを包括的に書いてあってわかりやすい。初心者向け　|
