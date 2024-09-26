import 'package:dio/dio.dart';
import 'package:stream_feed_unofficial/src/data/activity/models/feed_id_model.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/api_endpoint_helper.dart';

class FollowRemoteDataSource {
  final Dio dio;

  FollowRemoteDataSource(this.dio);

  /// Follows a target feed
  /// This is more like a workaround
  /// You can reach out to getStream support team,
  /// they can also enable global feed for any feed
  Future<void> globalUserFollowsCurrentUserFeed({
    required String feedName,
    required String username,
    required String globalUsername,
    int activityCopyLimit = 300,
  }) async {
    try {
      final path = ApiEndpoint.buildGlobalUserFollowsCurrentUser(
        FeedId(feedName, globalUsername),
      );
      final queryParams = {'activity_copy_limit': activityCopyLimit};

      final response = await dio.post(
        path,
        queryParameters: queryParams,
        data: {'target': '$feedName:$username'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to follow feed');
      }
    } catch (e) {
      throw Exception('Error following feed: $e');
    }
  }
}
