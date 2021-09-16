// Qiitaから取ってきたユーザを管理するモデル
class User {
  final String id;
  final String name;
  final String description;
  final String profileImageUrl;
  final int itemsCount;
  final int followersCount;

  User({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImageUrl,
    required this.itemsCount,
    required this.followersCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      profileImageUrl: json['profile_image_url'],
      itemsCount: json['items_count'],
      followersCount: json['followers_count'],
    );
  }
}
