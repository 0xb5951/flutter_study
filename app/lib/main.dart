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

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Todoリストの一覧画面'),
      ),
    );
  }
}
