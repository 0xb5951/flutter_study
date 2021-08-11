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
      home: HomeRoutePage(),
      routes: <String, WidgetBuilder>{
        'main': (BuildContext context) => new HomeRoutePage(),
        'todos': (BuildContext context) => new TodoListPage(),
      },
    );
  }
}

class HomeRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("メインルート画面")),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("TODOリスト"),
              onTap: () {
                Navigator.of(context).pushNamed('todos');
              },
            ),
          )
        ],
      ),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

// 一覧画面
class _TodoListPageState extends State<TodoListPage> {
  List<String> _todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODOリスト一覧"),
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // 押した時
        onPressed: () async {
          // 追加画面からのデータを受け取る
          final newLineText = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            // TODO追加画面に移動
            return TodoAddPage();
          }));
          // 戻ってきたデータがない場合は空になるので、はじく
          if (newLineText != null) {
            setState(() {
              _todoList.add(newLineText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

// 追加画面
class _TodoAddPageState extends State<TodoAddPage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("リスト追加画面")),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 入力したテキストを表示
            Text(
              _text,
              style: TextStyle(color: Colors.blue),
            ),
            TextField(
              // 入力されたテキストを更新する(valueが更新されたテキスト)
              onChanged: (String value) {
                // ステートを更新
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  // 前の画面にテキストデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: Text("リスト追加", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("キャンセル"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
