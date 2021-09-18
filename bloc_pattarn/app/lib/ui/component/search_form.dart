import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            enabled: true,
            onTap: () {},
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
