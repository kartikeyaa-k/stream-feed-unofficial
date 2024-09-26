// domain/follow/repositories/follow_repository.dart

/// `FollowRepository` defines the contract for follow-related operations,
/// such as making a global user follow the current user's feed.
abstract class FollowRepository {
  /// Makes a global user follow the current user's feed.
  ///
  /// Parameters:
  /// - [feedName]: The name of the feed to follow.
  /// - [username]: The username of the current user.
  /// - [globalUsername]: The global user's username who will follow the feed.
  /// - [activityCopyLimit]: The limit on the number of activities to copy during the follow.
  ///
  /// Returns:
  /// - A `Future` that completes when the follow operation is successful.
  Future<void> globalUserFollowsCurrentUserFeed({
    required String feedName,
    required String username,
    required String globalUsername,
    int activityCopyLimit,
  });
}
