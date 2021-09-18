class RepositoryItem {
  String fullName;
  int stargazersCount;
  Uri htmlUrl;

  RepositoryItem({
    required this.fullName,
    required this.stargazersCount,
    required this.htmlUrl,
  });

  factory RepositoryItem.fromJson(Map<String, dynamic> json) {
    return RepositoryItem(
      fullName: json['full_name'],
      stargazersCount: json['stargazers_count'],
      htmlUrl: Uri.parse(json['html_url']),
    );
  }

  static List<RepositoryItem> repositoryListFromJson(
      Map<String, dynamic> json) {
    return json['items']
        .map((item) {
          return RepositoryItem.fromJson(item);
        })
        .toList()
        .cast<RepositoryItem>() as List<RepositoryItem>;
  }
}
