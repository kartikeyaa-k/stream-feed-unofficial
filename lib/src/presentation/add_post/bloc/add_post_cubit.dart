import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/src/domain/activity/usecases/add_activity_usecase.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

part 'add_post_state.dart';

/// `AddPostCubit` manages the state of adding a new post to a feed.
/// It interacts with the `AddPostUsecase` to handle the process of creating posts,
/// managing URL detection within the post content, and handling Open Graph preview data.
///
/// This cubit is responsible for emitting states that reflect the progress and results of
/// adding a post, including loading, success, and error states, along with handling URL
/// extraction and Open Graph previews for enhanced post creation.
class AddPostCubit extends Cubit<AddPostState> {
  final AddPostUsecase addPostUsecase;

  String?
      _lastDetectedUrl; // Stores the last detected URL to avoid redundant processing.
  Timer?
      _debounceTimer; // Timer for debouncing URL detection to prevent excessive processing.
  List<String> _hyperlinkList =
      []; // List of hyperlinks detected from the post content.

  /// Constructs an `AddPostCubit` with the provided [addPostUsecase].
  ///
  /// - [addPostUsecase]: The use case responsible for adding posts to a feed.
  AddPostCubit(
    this.addPostUsecase,
  ) : super(AddPostInitial());

  /// Adds a new post to the specified feed with the given content and optional metadata.
  ///
  /// This method uses the `AddPostUsecase` to create a new post, emitting states that
  /// reflect the loading, success, or error outcomes of the operation.
  ///
  /// Parameters:
  /// - [content]: The content of the post to be added.
  /// - [username]: The username of the user creating the post.
  /// - [feedName]: The name of the feed group where the post will be added.
  /// - [openGraphEntity]: Optional. Open Graph metadata for rich preview enhancements.
  /// - [userProfileImageUrl]: Optional. URL of the user's profile image to be associated with the post.
  ///
  /// Emits:
  /// - `AddPostLoading`: When the post is being added.
  /// - `AddPostSuccess`: When the post is successfully added.
  /// - `AddPostError`: When there is an error in adding the post.
  Future<void> addPost({
    required String content,
    required String username,
    required String feedName,
    OpenGraphEntity? openGraphEntity,
    String? userProfileImageUrl,
  }) async {
    emit(AddPostLoading());
    try {
      await addPostUsecase.call(
        content: content,
        username: username,
        userProfileImageUrl: userProfileImageUrl,
        feedName: feedName,
        hyperlinks: _hyperlinkList,
        openGraphEntity: openGraphEntity,
      );
      emit(AddPostSuccess());
    } catch (e) {
      emit(const AddPostError('Failed to add post'));
    }
  }

  /// Detects URLs within the provided input text and updates the state to reflect URL-related changes.
  ///
  /// This method uses a debounce mechanism to limit the frequency of URL extraction and state updates.
  /// If URLs are detected, it triggers fetching Open Graph data for the last detected URL.
  ///
  /// Parameters:
  /// - [input]: The text input from which URLs are to be detected.
  ///
  /// Emits:
  /// - `FetchUrlPreviewRequested`: When a new URL is detected and Open Graph data needs to be fetched.
  void detectUrl(String input) {
    // Cancel previous debounce timer if it exists
    _debounceTimer?.cancel();

    // Start a new debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final urls = _extractUrls(input); // Extract all URLs from the input
      _hyperlinkList = urls; // Update _hyperlinkList with the extracted URLs
      if (urls.isNotEmpty) {
        // Fetch Open Graph data only for the first detected URL
        if (urls.last != _lastDetectedUrl) {
          _lastDetectedUrl = urls.last;
          emit(FetchUrlPreviewRequested(_lastDetectedUrl!));
        }
      } else {
        _lastDetectedUrl = null;
      }
    });
  }

  /// Extracts all URLs from the given input string.
  ///
  /// This helper method uses a regular expression to identify and return all
  /// URLs found in the input text, which are then used for further processing.
  ///
  /// Parameters:
  /// - [input]: The text input from which URLs are to be extracted.
  ///
  /// Returns:
  /// - A list of strings representing the extracted URLs.
  List<String> _extractUrls(String input) {
    final urlPattern = RegExp(
      r'((https?|ftp)://[^\s/$.?#].[^\s]*)',
      caseSensitive: false,
    );

    // Find all matches and map them to a list of strings
    return urlPattern
        .allMatches(input)
        .map((match) => match.group(0)!)
        .toList();
  }

  /// Removes the currently detected URL preview and updates the state.
  ///
  /// This method is used to reset the URL preview when the user chooses to
  /// remove it, helping maintain a clean post creation experience.
  ///
  /// Emits:
  /// - `PreviewRemoved`: When the URL preview is removed from the state.
  void removePreview() {
    _lastDetectedUrl = null;
    emit(PreviewRemoved());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel(); // Cancel debounce timer when cubit is closed
    return super.close();
  }
}
