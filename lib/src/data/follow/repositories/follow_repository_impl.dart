import 'package:stream_feed_unofficial/src/data/follow/datasources/follow_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/domain/follow/repositories/follow_repository.dart';

class FollowRepositoryImpl implements FollowRepository {
  final FollowRemoteDataSource remoteDataSource;

  FollowRepositoryImpl(this.remoteDataSource);

  /// Follows a target feed
  /// This is more like a workaround
  /// You can reach out to getStream support team,
  /// they can also enable global feed for any feed
  ///
  @override
  Future<void> globalUserFollowsCurrentUserFeed({
    required String feedName,
    required String username,
    required String globalUsername,
    int activityCopyLimit = 300,
  }) async {
    await remoteDataSource.globalUserFollowsCurrentUserFeed(
      feedName: feedName,
      username: username,
      globalUsername: globalUsername,
      activityCopyLimit: activityCopyLimit,
    );
  }
}
