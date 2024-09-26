// data/activity/datasources/activity_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:stream_feed_unofficial/src/data/activity/models/activity_model.dart';
import 'package:stream_feed_unofficial/src/data/activity/models/feed_id_model.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/api_endpoint_helper.dart';
import 'package:stream_feed_unofficial/src/domain/core/repositories/auth_repository.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

/// `ActivityRemoteDataSource` handles communication with the remote server
/// to manage activities (posts) within the application. It provides methods
/// to fetch activities from a feed and add new posts to a feed.
///
/// This class utilizes the Dio package for HTTP requests and leverages
/// the `AuthRepository` to manage authentication-related actions.
///
/// Dependencies:
/// - `Dio`: A powerful HTTP client for Dart.
/// - `AuthRepository`: A repository to handle authentication actions.
/// - `ApiEndpointHelper`: Utility to construct API endpoints.
/// - `ActivityModel`: Model representing an activity (post).
/// - `FeedId`: Model representing a feed identifier.
/// - `OpenGraphEntity`: Entity representing Open Graph data, used to fetch metadata like preview images, titles, and descriptions.

class ActivityRemoteDataSource {
  final Dio dio;
  final AuthRepository authRepository;

  /// Constructor that initializes the data source with a Dio client
  /// and an AuthRepository for handling authentication tokens.
  ///
  /// - [dio]: The HTTP client used to make network requests.
  /// - [authRepository]: Handles authentication-related operations.
  ActivityRemoteDataSource({
    required this.dio,
    required this.authRepository,
  });

  /// Fetches a list of activities (posts) from the specified feed.
  ///
  /// Parameters:
  /// - [username]: The user's username, used as part of the feed ID.
  /// - [feedName]: The name of the feed to fetch activities from.
  /// - [limit]: Optional. The maximum number of activities to return. Default is 10.
  /// - [offset]: Optional. The starting point for the fetch. Default is 0.
  /// - [session]: Optional. A session identifier for server-side tracking.
  /// - [ranking]: Optional. Specifies a ranking algorithm to apply to the activities.
  ///
  /// Returns:
  /// - A list of `ActivityModel` representing the activities fetched from the server.
  ///
  /// Throws:
  /// - `DioError` if the request fails.
  Future<List<ActivityModel>> getActivities({
    required String username,
    required String feedName,
    int? limit,
    int? offset,
    String? session,
    String? ranking,
  }) async {
    final path = ApiEndpoint.buildEnrichedFeedUrl(
      FeedId(feedName, username),
    );

    final response = await dio.get<Map<String, dynamic>>(
      path,
      queryParameters: {
        'withReactionCounts': true,
        'withRecentReactions': true,
        'limit': limit ?? 10,
        'offset': offset ?? 0,
        if (ranking != null) 'ranking': ranking,
        if (session != null) 'session': session,
      },
    );

    // Parsing the response data to a list of ActivityModel objects
    final data = (response.data!['results'] as List)
        .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }

  /// Adds a new post to the specified feed.
  ///
  /// Parameters:
  /// - [content]: The content of the post.
  /// - [username]: The user's username, used as part of the feed ID.
  /// - [feedName]: The name of the feed to which the post is added.
  /// - [userProfileImageUrl]: Optional. The URL of the user's profile image.
  /// - [hyperlinks]: Optional. A list of hyperlinks included in the post.
  /// - [openGraphEntity]: Optional. Metadata for Open Graph previews.
  ///
  /// Throws:
  /// - `Exception` if the request to add the post fails.
  Future<void> addPost({
    required String content,
    required String username,
    required String feedName,
    String? userProfileImageUrl,
    List<String>? hyperlinks,
    OpenGraphEntity? openGraphEntity,
  }) async {
    final path = ApiEndpoint.buildFeedUrl(FeedId(feedName, username));

    final response = await dio.post(
      path,
      data: {
        'id': '$username-id',
        'actor': 'User:$username',
        'verb': 'post',
        'object': 'Post:1',
        'foreign_id': 'post:${DateTime.now().millisecondsSinceEpoch}',
        'time': DateTime.now().toIso8601String(),
        'message': content,
        'extra_data': {
          'message': content,
          'user_profile_image_url': userProfileImageUrl,
          'hyperlinks': hyperlinks,
          'open_graph_preview_url':
              openGraphEntity?.images?.first.image.toString() ??
                  openGraphEntity?.favicon,
          'open_graph_preview_title': openGraphEntity?.title,
          'open_graph_preview_desc': openGraphEntity?.description,
        },
      },
    );

    // Check if the response status code indicates success; otherwise, throw an exception
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add post');
    }
  }
}
