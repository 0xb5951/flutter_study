import 'package:app/blocs/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

TextEditingController queryInputController = TextEditingController(text: '');

class SearchForm extends StatelessWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            enabled: true,
            controller: queryInputController,
            decoration: InputDecoration(
              hintText: "検索キーワード",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text(
              "検索",
              style: TextStyle(color: Colors.black),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.grey[400]),
            onPressed: () {
              searchBloc.changeQuery.add(queryInputController.text);
            },
          ),
        ],
      ),
    );
  }
}
