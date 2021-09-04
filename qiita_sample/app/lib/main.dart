import 'package:flutter/material.dart';
import 'package:app/screen/sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}
