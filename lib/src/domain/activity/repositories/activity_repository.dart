// domain/activity/repositories/activity_repository.dart

import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

/// `ActivityRepository` defines the contract for managing activities (posts)
/// within the application. It provides methods to fetch activities from a
/// feed and to add new posts to a feed.
///
/// This interface is implemented by classes that handle data interactions,
/// such as fetching activities from remote data sources or adding new posts.
abstract class ActivityRepository {
  /// Fetches a list of activities (posts) from a specified feed.
  ///
  /// This method interacts with data sources to retrieve activities that
  /// belong to a specific user and feed group. It supports pagination,
  /// session tracking, and ranking customizations.
  ///
  /// Parameters:
  /// - [limit]: Optional. The maximum number of activities to retrieve. Default is undefined.
  /// - [offset]: Optional. The number of activities to skip before starting to collect the result set. Default is undefined.
  /// - [session]: Optional. A session identifier for server-side tracking and optimizations. Default is undefined.
  /// - [ranking]: Optional. Specifies a ranking algorithm to order the activities (e.g., chronological, engagement-based).
  /// - [username]: The username of the user whose feed is being queried.
  /// - [feedName]: The name of the feed group to fetch activities from, such as "user" or "timeline".
  ///
  /// Returns:
  /// - A `Future` containing a list of `ActivityEntity` objects, which represent the activities fetched from the feed.
  ///
  /// Throws:
  /// - May throw exceptions related to network errors, data parsing issues, or authorization failures.
  Future<List<ActivityEntity>> fetchActivities({
    int? limit,
    int? offset,
    String? session,
    String? ranking,
    required String username,
    required String feedName,
  });

  /// Adds a new post to the specified feed.
  ///
  /// This method constructs the data for a new post and interacts with
  /// data sources to add it to a specific user's feed. It supports adding
  /// Open Graph metadata, hyperlinks, and user profile images for richer posts.
  ///
  /// Parameters:
  /// - [content]: The content of the post being added.
  /// - [username]: The username of the user creating the post.
  /// - [feedName]: The name of the feed group where the post will be added, such as "user" or "timeline".
  /// - [userProfileImageUrl]: Optional. URL of the user's profile image to be displayed with the post.
  /// - [hyperlinks]: Optional. A list of hyperlinks included in the post content, supporting richer engagement.
  /// - [openGraphEntity]: Optional. Open Graph metadata that enhances the post with rich previews, such as images and descriptions.
  ///
  /// Returns:
  /// - A `Future` that completes when the post has been successfully added to the feed.
  ///
  /// Throws:
  /// - May throw exceptions related to network errors, validation failures, or permission issues.
  Future<void> addPost({
    required String content,
    required String username,
    required String feedName,
    String? userProfileImageUrl,
    List<String>? hyperlinks,
    OpenGraphEntity? openGraphEntity,
  });
}
