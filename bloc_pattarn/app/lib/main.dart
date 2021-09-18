import 'package:app/ui/screen/post_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Learn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: PostView()),
    );
  }
}
