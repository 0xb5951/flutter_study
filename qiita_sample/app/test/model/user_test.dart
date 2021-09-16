import 'dart:convert';

import 'package:app/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Qiitaの戻り値からUserオブジェクトに返還できるか', () {
      final expectedJson = {
        'description': '',
        'facebook_id': '',
        'followees_count': 23,
        'followers_count': 20,
        'github_login_name': 'odrum428',
        'id': 'odrum428',
        'items_count': 5,
        'linkedin_id': '',
        'location': '',
        'name': '',
        'organization': '',
        'permanent_id': 285875,
        'profile_image_url':
            'https://avatars0.githubusercontent.com/u/33741792?v=4',
        'team_only': false,
        'twitter_screen_name': null,
        'website_url': '',
        'image_monthly_upload_limit': 104857600,
        'image_monthly_upload_remaining': 104857600
      };

      User.fromJson(expectedJson);
    });
  });
}
