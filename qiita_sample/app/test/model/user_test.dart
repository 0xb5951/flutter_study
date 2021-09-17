import 'package:app/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Qiitaの戻り値からUserオブジェクトに変換できるか', () {
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
      final user = User.fromJson(expectedJson);

      expect(user.id, 'odrum428');
      expect(user.name, '');
      expect(user.description, '');
      expect(user.profileImageUrl,
          'https://avatars0.githubusercontent.com/u/33741792?v=4');
      expect(user.itemsCount, 5);
      expect(user.followersCount, 20);
    });

    test('日本語が入ったデータでも行けるか', () {
      final expectedJson = {
        'description': '''ガチSIer
※このサイトの投稿は私自身のものであり、必ずしも IBM の立場、戦略、意見を表すものではありません''',
        'facebook_id': '',
        'followees_count': 11,
        'followers_count': 37,
        'github_login_name': 'teruz',
        'id': 'teruq',
        'items_count': 106,
        'linkedin_id': '',
        'location': '',
        'name': 'Teruyuki Takazawa',
        'organization': '',
        'permanent_id': 241424,
        'profile_image_url':
            'https://qiita-image-store.s3.amazonaws.com/0/241424/profile-images/1520102841',
        'team_only': false,
        'twitter_screen_name': null,
        'website_url': ''
      };

      final user = User.fromJson(expectedJson);

      expect(user.id, 'teruq');
      expect(user.name, 'Teruyuki Takazawa');
      expect(user.description, '''ガチSIer
※このサイトの投稿は私自身のものであり、必ずしも IBM の立場、戦略、意見を表すものではありません''');
      expect(user.profileImageUrl,
          'https://qiita-image-store.s3.amazonaws.com/0/241424/profile-images/1520102841');
      expect(user.itemsCount, 106);
      expect(user.followersCount, 37);
    });
  });
}
