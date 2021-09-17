import 'package:app/model/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Qiitaの戻り値からTagオブジェクトに変換できるか', () {
      final expectedJson = {
        "rendered_body": "<h1>Example</h1>",
        "body": "# Example",
        "coediting": false,
        "comments_count": 100,
        "created_at": "2000-01-01T00:00:00+00:00",
        "group": {
          "created_at": "2000-01-01T00:00:00+00:00",
          "description": "This group is for developers.",
          "name": "Dev",
          "private": false,
          "updated_at": "2000-01-01T00:00:00+00:00",
          "url_name": "dev"
        },
        "id": "c686397e4a0f4f11683d",
        "likes_count": 100,
        "private": false,
        "reactions_count": 100,
        "tags": [
          {
            "name": "Ruby",
            "versions": ["0.0.1"]
          }
        ],
        "title": "Example title",
        "updated_at": "2000-01-01T00:00:00+00:00",
        "url": "https://qiita.com/Qiita/items/c686397e4a0f4f11683d",
        "user": {
          "description": "Hello, world.",
          "facebook_id": "qiita",
          "followees_count": 100,
          "followers_count": 200,
          "github_login_name": "qiitan",
          "id": "qiita",
          "items_count": 300,
          "linkedin_id": "qiita",
          "location": "Tokyo, Japan",
          "name": "Qiita キータ",
          "organization": "Increments Inc",
          "permanent_id": 1,
          "profile_image_url":
              "https://s3-ap-northeast-1.amazonaws.com/qiita-image-store/0/88/ccf90b557a406157dbb9d2d7e543dae384dbb561/large.png?1575443439",
          "team_only": false,
          "twitter_screen_name": "qiita",
          "website_url": "https://qiita.com"
        },
        "page_views_count": 100,
        "team_membership": {"name": "Qiita キータ"}
      };

      final item = Item.fromJson(expectedJson);

      expect(item.id, "c686397e4a0f4f11683d");
      expect(item.title, "Example title");
      expect(item.renderedBody, "<h1>Example</h1>");
      expect(item.createdAt, DateTime.parse("2000-01-01T00:00:00+00:00"));
      expect(item.likesCount, 100);
      expect(item.tags.length, 1);
    });

    test('複数件あったときに、正しく変換できるか', () {
      final expectedJson = [
        {
          "rendered_body": "<h1>Example</h1>",
          "body": "# Example",
          "coediting": false,
          "comments_count": 100,
          "created_at": "2000-01-01T00:00:00+00:00",
          "group": {
            "created_at": "2000-01-01T00:00:00+00:00",
            "description": "This group is for developers.",
            "name": "Dev",
            "private": false,
            "updated_at": "2000-01-01T00:00:00+00:00",
            "url_name": "dev"
          },
          "id": "c686397e4a0f4f11683d",
          "likes_count": 100,
          "private": false,
          "reactions_count": 100,
          "tags": [
            {
              "name": "Ruby",
              "versions": ["0.0.1"]
            }
          ],
          "title": "Example title",
          "updated_at": "2000-01-01T00:00:00+00:00",
          "url": "https://qiita.com/Qiita/items/c686397e4a0f4f11683d",
          "user": {
            "description": "Hello, world.",
            "facebook_id": "qiita",
            "followees_count": 100,
            "followers_count": 200,
            "github_login_name": "qiitan",
            "id": "qiita",
            "items_count": 300,
            "linkedin_id": "qiita",
            "location": "Tokyo, Japan",
            "name": "Qiita キータ",
            "organization": "Increments Inc",
            "permanent_id": 1,
            "profile_image_url":
                "https://s3-ap-northeast-1.amazonaws.com/qiita-image-store/0/88/ccf90b557a406157dbb9d2d7e543dae384dbb561/large.png?1575443439",
            "team_only": false,
            "twitter_screen_name": "qiita",
            "website_url": "https://qiita.com"
          },
          "page_views_count": 100,
          "team_membership": {"name": "Qiita キータ"}
        },
        {
          "rendered_body": "<h1>Example</h1>",
          "body": "# Example",
          "coediting": false,
          "comments_count": 100,
          "created_at": "2000-01-01T00:00:00+00:00",
          "group": {
            "created_at": "2000-01-01T00:00:00+00:00",
            "description": "This group is for developers.",
            "name": "Dev",
            "private": false,
            "updated_at": "2000-01-01T00:00:00+00:00",
            "url_name": "dev"
          },
          "id": "c686397e4a0f4f11683d",
          "likes_count": 100,
          "private": false,
          "reactions_count": 100,
          "tags": [
            {
              "name": "Ruby",
              "versions": ["0.0.1"]
            }
          ],
          "title": "Example title",
          "updated_at": "2000-01-01T00:00:00+00:00",
          "url": "https://qiita.com/Qiita/items/c686397e4a0f4f11683d",
          "user": {
            "description": "Hello, world.",
            "facebook_id": "qiita",
            "followees_count": 100,
            "followers_count": 200,
            "github_login_name": "qiitan",
            "id": "qiita",
            "items_count": 300,
            "linkedin_id": "qiita",
            "location": "Tokyo, Japan",
            "name": "Qiita キータ",
            "organization": "Increments Inc",
            "permanent_id": 1,
            "profile_image_url":
                "https://s3-ap-northeast-1.amazonaws.com/qiita-image-store/0/88/ccf90b557a406157dbb9d2d7e543dae384dbb561/large.png?1575443439",
            "team_only": false,
            "twitter_screen_name": "qiita",
            "website_url": "https://qiita.com"
          },
          "page_views_count": 100,
          "team_membership": {"name": "Qiita キータ"}
        },
      ];

      final itemList = expectedJson.map((item) {
        return Item.fromJson(item);
      }).toList();

      expect(itemList.length, 2);
      expect(itemList[0].id, "c686397e4a0f4f11683d");
      expect(itemList[0].title, "Example title");
      expect(itemList[0].renderedBody, "<h1>Example</h1>");
      expect(
          itemList[0].createdAt, DateTime.parse("2000-01-01T00:00:00+00:00"));
      expect(itemList[0].likesCount, 100);
      expect(itemList[0].tags.length, 1);

      expect(itemList[1].id, "c686397e4a0f4f11683d");
      expect(itemList[1].title, "Example title");
      expect(itemList[1].renderedBody, "<h1>Example</h1>");
      expect(
          itemList[1].createdAt, DateTime.parse("2000-01-01T00:00:00+00:00"));
      expect(itemList[1].likesCount, 100);
      expect(itemList[1].tags.length, 1);
    });
  });
}
