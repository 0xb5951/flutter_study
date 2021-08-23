import 'package:flutter/material.dart';
import "package:app/todos.dart";
import "package:app/admin_mobile.dart";
import 'package:app/signIn/main.dart';
import 'package:app/battery_potimizer/main.dart';

void main() {
  runApp(TodoApp());
}

// ignore: use_key_in_widget_constructors
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      // テーマカラー
      theme: ThemeData.dark().copyWith(
        accentColor: kAccentColor,
      ),
      // Todoリスト一覧画面を表示
      home: HomeRoutePage(),
      routes: <String, WidgetBuilder>{
        'main': (BuildContext context) => HomeRoutePage(),
        'todos': (BuildContext context) => TodoListPage(),
        "admin_mobile": (BuildContext context) => AdminMobilePage(),
        'signup': (BuildContext context) => SignInPage(),
        'battery': (BuildContext context) => BatteryOptimizerPage(),
      },
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomeRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("メインルート画面")),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: const Text("TODOリスト"),
                onTap: () {
                  Navigator.of(context).pushNamed('todos');
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Admin Mobile"),
                onTap: () {
                  Navigator.of(context).pushNamed('admin_mobile');
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("SignIn"),
                onTap: () {
                  Navigator.of(context).pushNamed('signup');
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Battery Optimizer"),
                onTap: () {
                  Navigator.of(context).pushNamed("battery");
                },
              ),
            )
          ],
        ));
  }
}
