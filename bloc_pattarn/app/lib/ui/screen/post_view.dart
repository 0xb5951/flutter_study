import 'package:app/ui/component/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostView extends StatelessWidget {
  const PostView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SearchForm());
  }
}
