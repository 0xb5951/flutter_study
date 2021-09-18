
## 要件

- 検索内容が入力できる
- 入力された内容を元にGitHubに検索クエリを投げられる
- 取得した情報を元に、リポジトリの一覧が表示できる
- それぞれの内容をタップしたら、webviewで詳細画面に移動する
- 検索条件が変更されたら、一覧も更新される

## 実装

1. 検索条件を入力できる部分
2. 入力した検索条件を元に、GitHubのAPIからデータを取得する
3. データを受け取って、一覧表示する部分を実装
4. タップしたときの挙動や、細かい動きを実装

## フォルダ構成案
コードのアーキテクチャは以下と一緒でいいと思った。
https://qiita.com/arthur_foreign/items/4b1bf1892439780c4690


### UI
screenとcomponentで分離する。
- Screen層では、BLoC層で管理されている状態をProviderで受け取って、下位Widget(Component層)で扱えるようにする
- Component層では、Screen層からProvider.ofで状態を受け取ってUIを描画する

## tips