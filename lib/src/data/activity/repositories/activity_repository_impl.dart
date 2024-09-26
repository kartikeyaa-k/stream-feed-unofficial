// data/activity/repositories/activity_repository_impl.dart

import 'package:stream_feed_unofficial/src/data/activity/datasources/activity_remote_datasource.dart';
import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
import 'package:stream_feed_unofficial/src/domain/activity/repositories/activity_repository.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

/// Implementation of the `ActivityRepository` interface.
///
/// This class acts as a bridge between the domain layer and the data layer,
/// handling the retrieval and manipulation of activity data by interacting
/// with the `ActivityRemoteDataSource`. It converts raw data models into
/// domain entities that are used throughout the application.
class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  /// Creates an instance of `ActivityRepositoryImpl` with the provided
  /// remote data source.
  ///
  /// - [remoteDataSource]: The data source responsible for handling remote
  ///   API calls related to activities (posts).
  ActivityRepositoryImpl(this.remoteDataSource);

  /// Fetches a list of activities from a specific feed by delegating the call
  /// to the `ActivityRemoteDataSource`. The raw data models are then converted
  /// into `ActivityEntity` objects for use within the domain layer.
  ///
  /// Parameters:
  /// - [limit]: Optional. The maximum number of activities to retrieve. Default is null.
  /// - [offset]: Optional. The number of activities to skip before starting to collect the result set.
  /// - [session]: Optional. A session identifier for tracking server-side operations.
  /// - [ranking]: Optional. Specifies the ranking algorithm to use when fetching activities.
  /// - [username]: The username of the user whose feed is being queried.
  /// - [feedName]: The name of the feed group to fetch activities from.
  ///
  /// Returns:
  /// - A `Future` containing a list of `ActivityEntity` objects representing
  ///   the activities fetched from the feed.
  ///
  /// Throws:
  /// - May throw network-related exceptions if the remote data source encounters an error.
  @override
  Future<List<ActivityEntity>> fetchActivities({
    int? limit,
    int? offset,
    String? session,
    String? ranking,
    required String username,
    required String feedName,
  }) async {
    final activities = await remoteDataSource.getActivities(
      limit: limit,
      offset: offset,
      session: session,
      ranking: ranking,
      username: username,
      feedName: feedName,
    );
    return activities.map((activity) => activity.toEntity()).toList();
  }

  /// Adds a new post to the specified feed by delegating the operation
  /// to the `ActivityRemoteDataSource`. This method handles constructing
  /// the appropriate data to send, including optional Open Graph metadata.
  ///
  /// Parameters:
  /// - [content]: The content of the post to be added.
  /// - [username]: The username of the user creating the post.
  /// - [feedName]: The name of the feed group where the post will be added.
  /// - [userProfileImageUrl]: Optional. URL of the user's profile image to be displayed with the post.
  /// - [hyperlinks]: Optional. A list of hyperlinks included in the post content.
  /// - [openGraphEntity]: Optional. Open Graph metadata for enhancing the post with rich previews.
  ///
  /// Returns:
  /// - A `Future` that completes when the post has been successfully added.
  ///
  /// Throws:
  /// - May throw exceptions if the post cannot be added due to network or validation errors.
  @override
  Future<void> addPost({
    required String content,
    required String username,
    required String feedName,
    String? userProfileImageUrl,
    List<String>? hyperlinks,
    OpenGraphEntity? openGraphEntity,
  }) {
    return remoteDataSource.addPost(
      content: content,
      username: username,
      userProfileImageUrl: userProfileImageUrl,
      feedName: feedName,
      hyperlinks: hyperlinks,
      openGraphEntity: openGraphEntity,
    );
  }
}
