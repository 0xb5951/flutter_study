import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      // テーマカラー
      theme: ThemeData(primarySwatch: Colors.blue),
      // Todoリスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// 一覧画面
class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Todoリストの一覧画面'),
      ),
      floatingActionButton: FloatingActionButton(
        // 押した時
        onPressed: () {
          // Navigatorにpushすると、新しいページに移動
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            // TODO追加画面に移動
            return TodoAddPage();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// 追加画面
class TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          // ボタンを押した時
          onPressed: () {
            // 前の画面に戻る
            Navigator.of(context).pop();
          },
          child: Text("一覧画面に戻る"),
        ),
      ),
    );
  }
}
