import 'package:app/data/model/repository_item.dart';
import 'package:http/http.dart';
import 'dart:convert';

class GitHubApiProvider {
  Client httpClient = Client();
  final _baseUrl = "https://api.github.com/search/repositories?sort=stars&q=";

  Future<List<RepositoryItem>> fetchRepositoryList(String query) async {
    print(query);

    final response = await httpClient.get(Uri.parse(_baseUrl + query));
    print(response.body.toString());
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return RepositoryItem.repositoryListFromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch hoge list!');
    }
  }
}
