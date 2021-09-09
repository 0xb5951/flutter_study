import 'package:flutter/material.dart';

import 'package:app/model/Tag.dart';
import 'package:app/model/User.dart';

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
}
