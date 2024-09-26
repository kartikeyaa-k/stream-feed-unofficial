// data/core/utils/api_constants.dart

class ApiConstants {
  // Token Resource Constants
  static const String anyResource = '*';
  static const String usersResource = 'users';
  static const String feedResource = 'feed';
  static const String collectionsResource = 'collections';

  // Token Action Constants
  static const String anyAction = '*';
  static const String readAction = 'read';
  static const String writeAction = 'write';
  static const String deleteAction = 'delete';

  // API Path Constants
  static const String addToManyPath = 'feed/add_to_many';
  static const String followManyPath = 'follow_many';
  static const String unfollowManyPath = 'unfollow_many';
  static const String activitiesPath = 'activities';
  static const String personalizationPath = 'personalization';
  static const String enrichPersonalizationPath = 'enrich/personalization';
  static const String personalizationFeedPath =
      '$enrichPersonalizationPath/$feedPath';
  static const String enrichActivitiesPath = 'enrich/$activitiesPath';
  static const String activityUpdatePath = 'activity';
  static const String reactionsPath = 'reaction';
  static const String usersPath = 'user';
  static const String collectionsPath = 'collections';
  static const String openGraphPath = 'og';
  static const String feedPath = 'feed';
  static const String enrichedFeedPath = 'enrich/$feedPath';
  static const String filesPath = 'files';
  static const String imagesPath = 'images';
  static const String refreshPath = 'refresh';
  static const String statsFollowPath = 'stats/follow/';
  static const String followFeed = 'follows';
}
