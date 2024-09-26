// domain/activity/usecases/add_post_usecase.dart

import 'package:stream_feed_unofficial/src/domain/activity/repositories/activity_repository.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

/// `AddPostUsecase` manages the process of adding a new post to a feed.
/// It interacts with the `ActivityRepository` to perform the operation.
class AddPostUsecase {
  final ActivityRepository repository;

  /// Constructs an `AddPostUsecase` with the given [repository].
  ///
  /// - [repository]: The repository responsible for adding posts to a feed.
  AddPostUsecase(this.repository);

  /// Executes the use case to add a new post to the specified feed.
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
  Future<void> call({
    required String content,
    required String username,
    required String feedName,
    String? userProfileImageUrl,
    List<String>? hyperlinks,
    OpenGraphEntity? openGraphEntity,
  }) async {
    return repository.addPost(
      content: content,
      username: username,
      userProfileImageUrl: userProfileImageUrl,
      feedName: feedName,
      hyperlinks: hyperlinks,
      openGraphEntity: openGraphEntity,
    );
  }
}
