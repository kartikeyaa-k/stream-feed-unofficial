import 'package:stream_feed_unofficial/src/data/activity/models/feed_id_model.dart';
import 'package:stream_feed_unofficial/src/data/core/constants/api_constants.dart';

class ApiEndpoint {
  static String buildFeedUrl(FeedId feed, [String path = '']) =>
      '${ApiConstants.feedPath}/${feed.slug}/${feed.userId}/$path';

  static String buildPersonalizationURL(String resource, [String path = '']) =>
      '${ApiConstants.personalizationPath}/${ApiConstants.feedPath}/$resource/$path';

  static String buildEnrichedFeedUrl(FeedId feed, [String path = '']) =>
      '${ApiConstants.enrichedFeedPath}/${feed.slug}/${feed.userId}/$path';

  static String get enrichedActivitiesUrl => ApiConstants.enrichActivitiesPath;

  static String buildCollectionsUrl([String? path = '']) =>
      '${ApiConstants.collectionsPath}/$path';

  static String buildReactionsUrl([String path = '']) =>
      '${ApiConstants.reactionsPath}/$path';

  static String buildRefreshCDNUrl([String? path = '']) =>
      '$path/${ApiConstants.refreshPath}/';

  static String buildUsersUrl([String path = '']) =>
      '${ApiConstants.usersPath}/$path';

  static String buildFollowFeedUrl(FeedId feed, [String path = '']) =>
      '${ApiConstants.enrichedFeedPath}/${feed.slug}/${feed.userId}/${ApiConstants.followFeed}';

  static String buildGlobalUserFollowsCurrentUser(
    FeedId feed, [
    String path = '',
  ]) =>
      '${ApiConstants.feedPath}/${feed.slug}/${feed.userId}/${ApiConstants.followFeed}';

  static String get filesUrl => ApiConstants.filesPath;

  static String get imagesUrl => ApiConstants.imagesPath;

  static String get openGraphUrl => ApiConstants.openGraphPath;

  static String get activityUpdateUrl => ApiConstants.activityUpdatePath;

  static String get personalizedFeedUrl => ApiConstants.personalizationFeedPath;

  static String get addToManyUrl => ApiConstants.addToManyPath;

  static String get followManyUrl => ApiConstants.followManyPath;

  static String get unfollowManyUrl => ApiConstants.unfollowManyPath;

  static String get activitesUrl => ApiConstants.activitiesPath;

  static String get statsFollowUrl => ApiConstants.statsFollowPath;
}
