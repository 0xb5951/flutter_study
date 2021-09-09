// Qiitaから取得した投稿に付与されるタグを管理するクラス

class Tag {
  final String name;
  final List<String> versions;

  Tag({
    required this.name,
    required this.versions,
  });
}
