import 'package:app/model/tag.dart';
import 'package:app/model/user.dart';

// Qiitaから取得した投稿一覧を表すモデル

class Item {
  final String id;
  final String title;
  final String renderedBody;
  final DateTime createdAt;
  final int likesCount;
  final List<Tag> tags;
  final User user;

  Item({
    required this.id,
    required this.title,
    required this.renderedBody,
    required this.createdAt,
    required this.likesCount,
    required this.tags,
    required this.user,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      renderedBody: json['rendered_body'],
      createdAt: DateTime.parse(json['created_at']),
      likesCount: json['likes_count'],
      tags: (json['tags'] as List<dynamic>).map((tagJson) {
        return Tag.fromJson(tagJson);
      }).toList(),
      user: User.fromJson(json['user']),
    );
  }
}
