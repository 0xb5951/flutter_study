import 'package:app/blocs/search_bloc.dart';
import 'package:app/ui/screen/post_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: MultiProvider(
        providers: [
          Provider<SearchBloc>(
            create: (context) => SearchBloc(),
            dispose: (context, bloc) => bloc.dispose(),
          )
        ],
        child: PostView(),
      ),
    );
  }
}
