import 'package:flutter/material.dart';

// Qiitaから取得したプロフィールアイコンを管理する
class UserProfileIcon extends StatelessWidget {
  final double size;
  final String profileImageUrl;

  const UserProfileIcon({
    Key? key,
    required this.size,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        profileImageUrl,
        width: size,
        height: size,
        // ネットワークからの取得に失敗したときに表示する
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
