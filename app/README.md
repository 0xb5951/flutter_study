# 目的
Flutterのことを理解するために簡単なTODOアプリを作る。
基本的に以下の記事を写経する。
https://www.flutter-study.dev/todo-app/about-todo-app


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


## 参考になる資料

|資料名|リンク|コメント|
|--|--|--|
|Flutter実践入門 ～環境構築からAndroid/iOS/Webに広告を付けて同時にリリース!!～|https://zenn.dev/kazutxt/books/flutter_practice_introduction| Dartの基本からFlutterでデプロイするまでを包括的に書いてあってわかりやすい。初心者向け　|
