# 目的
UIの練習でFlutterの肌間が分かってきたので、次はもうちょっとアプリっぽいものを作ってみる。
以下のページを参考にQiitaが閲覧できるサービスを作ってみる。
https://www.flutter-study.dev/create-app/qiita-app

## 概要
Qiitaの記事一覧を

## 要件
- Qiitaの記事一覧を確認できる
- Qiitaにログインできる
- 記事一覧から詳細を確認できる
- ユーザごとのプロフィールを確認できる
- ログアウトできる

## 設計
### Qiita APIについて
![image](https://user-images.githubusercontent.com/33741792/131454938-c8cfffaa-0ad8-4433-a8f6-2d81292d97ed.png)


### ログイン周りの実装
![image](https://user-images.githubusercontent.com/33741792/131505440-17b112a3-9fff-4d2b-8750-0d4c2ee644fb.png)

1. Qiitaログイン用のURLをWebブラウザで開く
ブラウザでログイン用のURLが開くので、各自のユーザでログインする
2. リダイレクトURLからアクセストークン発行コードを受け取る
3. アクセストークン発行APIに発行コードを付与してリクエスト
4. アクセストークンを受け取りローカルに保存
5. 投稿一覧画面に遷移

ログインページを実装して、そこにロジックを載せていく。
![image](https://user-images.githubusercontent.com/33741792/131508441-a1b10f39-28ce-4a81-a66f-8d0815897bc7.png)

Qiitaのリダイレクト先URLにディープリンクを設定する。
ディープリンクの設定は、Android, iOSそれぞれの設定内で行う。

Androidの場合は以下のように設定する。
```
<activity>
    ...
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data
            android:scheme="qiitaapp"
            android:host="dev.flutterstudy.qiitaapp" />
    </intent-filter>
</activity>
```

この場合、このアプリを認識するためのリンクは以下になる。
qiitaapp://dev.flutterstudy.qiitaapp

リダイレクトURLを上記に設定しても、ちゃんと元のアプリに画面遷移してくれた。
理由がわからない。

dev.mike.qiitaapp にしたら、リダイレクトされなくなった。

#### AndroidManifestの更新
ディープリンクの設定で、以下のような動作を行った。
1. qiitaapp://dev.flutterstudy.qiitaappというリンクで、正しく動作することを確認
2. AndroidManifest.xml側の設定をqiita-sample://dev.flutterstudy.qiitaappに変更
3. ホットリスタートして、再度同じ動作を実行

この場合でも、ディープリンクが動作することが確認できた。
AndroidManifestの更新をどうやって反映するのかがわからない。

解. ホットリスタートではAndroidManifestの更新は反映されない。
もう一度Flutter runし直したら、正しく動作した。

### 投稿一覧画面周りの実装
ログインが完了したら、投稿一覧画面に遷移する。
この画面では、ログインしているユーザが見られる
他のユーザの投稿一覧を確認することができる。

以下のAPIを使用する。、
https://qiita.com/api/v2/docs#%E6%8A%95%E7%A8%BF
```
GET /api/v2/items
記事の一覧を作成日時の降順で返します。

page
ページ番号 (1から100まで)
Example: 1
Type: string
Pattern: /^[0-9]+$/
per_page
1ページあたりに含まれる要素数 (1から100まで)
Example: 20
Type: string
Pattern: /^[0-9]+$/
query
検索クエリ
Example: "qiita user:Qiita"
Type: string
```


### tips
- ExpandedとButton組み合わせると、Buttonの要素がExpandedされるので、間に適当なWidgetを入れると良し
- url_launcherを使って、webブラウザを起動する
- 秘匿情報の管理にはflutter_dotenvを使う
- testの中でdotenv使う場合は、以下の初期化を行う必要がある
  TestWidgetsFlutterBinding.ensureInitialized();
  https://stackoverflow.com/questions/60686746/how-to-access-flutter-environment-variables-from-tests
- testは関数ごとにgruopでくくる
- widgetクラスの中で、別の一般クラスを呼び出すにはstaticつければ良い
- 例外をテストする場合は以下のようにする
```
expect(repository.createAccessTokenFromCallbackUri(uri, 'correct_state'),
    throwsA(const TypeMatcher<Exception>()));
```
- mockクラスの生成はbuild_runnerを使用する
- mockクラスは、ここの環境で生成する
- flutter logsコマンドで標準出力が見れる
- initStateはホットリロードでは初期化されない
https://flutter.dev/docs/development/tools/hot-reload

- LateInitializationErrorはlate宣言された変数が、代入前に使われていることが原因
- CircularProgressIndicatorは読み込まれるまで、Stateが更新され続ける