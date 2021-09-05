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

### tips
- ExpandedとButton組み合わせると、Buttonの要素がExpandedされるので、間に適当なWidgetを入れると良し
- url_launcherを使って、webブラウザを起動する
- 秘匿情報の管理にはflutter_dotenvを使う