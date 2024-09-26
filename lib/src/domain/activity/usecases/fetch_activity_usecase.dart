// domain/activity/usecases/fetch_activities_usecase.dart

import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
import 'package:stream_feed_unofficial/src/domain/activity/repositories/activity_repository.dart';

/// `FetchActivitiesUsecase` handles the business logic for fetching
/// activities (posts) from a specified feed. It interacts with the
/// `ActivityRepository` to fetch the data and returns a list of domain-level
/// entities (`ActivityEntity`).
class FetchActivitiesUsecase {
  final ActivityRepository repository;

  /// Constructs a `FetchActivitiesUsecase` with the provided [repository].
  ///
  /// - [repository]: The repository responsible for fetching activities.
  FetchActivitiesUsecase(this.repository);

  /// Executes the use case to fetch activities from a feed.
  ///
  /// Parameters:
  /// - [limit]: Optional. The maximum number of activities to retrieve.
  /// - [offset]: Optional. The number of activities to skip before starting to collect the result set.
  /// - [session]: Optional. A session identifier for tracking server-side operations.
  /// - [ranking]: Optional. Specifies the ranking algorithm to use when fetching activities.
  /// - [username]: The username of the user whose feed is being queried.
  /// - [feedName]: The name of the feed group to fetch activities from.
  ///
  /// Returns:
  /// - A `Future` containing a list of `ActivityEntity` objects.
  Future<List<ActivityEntity>> call({
    int? limit,
    int? offset,
    String? session,
    String? ranking,
    required String username,
    required String feedName,
  }) {
    return repository.fetchActivities(
      limit: limit,
      offset: offset,
      session: session,
      ranking: ranking,
      username: username,
      feedName: feedName,
    );
  }
}
