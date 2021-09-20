import 'dart:async';

import 'package:app/data/data_source/github_api_provider.dart';

class SearchBloc {
  final gitHubApi = GitHubApiProvider();

  // 検索条件からクエリを管理
  final searchQueryController = StreamController<String>();
  Stream<String> get query => searchQueryController.stream;
  StreamSink<String> get changeQuery => searchQueryController.sink;

  // GitHubから取ってきた結果の状態を管理
  final searchResultController = StreamController<List<dynamic>>();
  Stream<List<dynamic>> get result => searchResultController.stream;
  StreamSink<List<dynamic>> get changeResult => searchResultController.sink;

  SearchBloc() {
    query.listen((v) async {
      // APIの返り値となるSearchResult型を自作したと仮定
      final List<dynamic> searchResults =
          await gitHubApi.fetchRepositoryList(v);
      print("------");
      print(searchResults);
      print("------");
      if (searchResults.isEmpty) {
        changeResult.addError(searchResults);
      } else {
        changeResult.add(searchResults);
      }
    });
  }

  void dispose() {
    searchResultController.close();
    searchQueryController.close();
  }
}
