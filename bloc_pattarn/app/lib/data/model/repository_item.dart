class RepositoryItem {
  String fullName;
  String stargazersCount;
  String htmlUrl;

  RepositoryItem({
    required this.fullName,
    required this.stargazersCount,
    required this.htmlUrl,
  });

  factory RepositoryItem.fromJson(Map<String, dynamic> json) {
    return RepositoryItem(
      fullName: json['full_name'],
      stargazersCount: json['stargazers_count'],
      htmlUrl: json['html_url'],
    );
  }
}
