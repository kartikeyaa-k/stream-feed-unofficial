// domain/follow/usecases/global_user_follows_current_user_usecase.dart

import 'package:stream_feed_unofficial/src/domain/follow/repositories/follow_repository.dart';

/// `GlobalUserFollowsCurrentUserUsecase` manages the process of making a
/// global user follow the current user's feed. It leverages the
/// `FollowRepository` to perform the follow operation.
class GlobalUserFollowsCurrentUserUsecase {
  final FollowRepository followRepository;

  /// Constructs a `GlobalUserFollowsCurrentUserUsecase` with the given [followRepository].
  ///
  /// - [followRepository]: The repository handling follow-related operations.
  GlobalUserFollowsCurrentUserUsecase(this.followRepository);

  /// Executes the use case to make a global user follow the current user's feed.
  ///
  /// Parameters:
  /// - [feedName]: The name of the feed to follow.
  /// - [username]: The username of the current user.
  /// - [globalUsername]: The global user's username who will follow the feed.
  /// - [activityCopyLimit]: The limit on the number of activities to copy during the follow. Default is 300.
  ///
  /// Returns:
  /// - A `Future` that completes when the follow operation is successful.
  Future<void> execute({
    required String feedName,
    required String username,
    required String globalUsername,
    int activityCopyLimit = 300,
  }) async {
    await followRepository.globalUserFollowsCurrentUserFeed(
      feedName: feedName,
      username: username,
      globalUsername: globalUsername,
      activityCopyLimit: activityCopyLimit,
    );
  }
}
