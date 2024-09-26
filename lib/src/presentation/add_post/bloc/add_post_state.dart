part of 'add_post_cubit.dart';

/// `AddPostState` is an abstract class that defines the various states
/// for the `AddPostCubit`. It extends `Equatable` to enable state comparisons,
/// which helps in efficiently managing UI updates based on state changes during
/// the post creation process.
abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object?> get props => [];
}

/// `AddPostInitial` represents the initial state of the `AddPostCubit`.
///
/// This state is emitted when the cubit is first created, indicating that
/// no post creation activity has started yet. It serves as the default state
/// before any interaction occurs.
class AddPostInitial extends AddPostState {}

/// `AddPostLoading` represents the loading state of the `AddPostCubit`.
///
/// This state is emitted when a post is in the process of being added to a feed,
/// signaling to the UI that a post creation operation is underway and that the user
/// should wait for it to complete.
class AddPostLoading extends AddPostState {}

/// `AddPostSuccess` represents the state when a post has been successfully added.
///
/// This state is emitted after a post is successfully created and added to the feed,
/// allowing the UI to reflect that the operation was completed successfully.
class AddPostSuccess extends AddPostState {}

/// `AddPostError` represents the error state of the `AddPostCubit`.
///
/// This state is emitted when an error occurs during the post creation process.
/// It contains a message describing the error, which can be displayed to the user
/// for feedback or troubleshooting.
///
/// Parameters:
/// - [message]: A string message describing the error encountered during the post creation.
class AddPostError extends AddPostState {
  final String message;

  /// Constructs an `AddPostError` state with the given error message.
  ///
  /// - [message]: The error message describing what went wrong during the post creation.
  const AddPostError(this.message);

  @override
  List<Object?> get props => [message];
}

/// `FetchUrlPreviewRequested` represents the state when a URL has been detected
/// in the post content and an Open Graph preview is requested.
///
/// This state is emitted when the `AddPostCubit` detects a new URL in the content
/// and needs to fetch Open Graph data to provide a rich preview of the URL.
///
/// Parameters:
/// - [url]: The detected URL for which Open Graph data is being requested.
class FetchUrlPreviewRequested extends AddPostState {
  final String url;

  /// Constructs a `FetchUrlPreviewRequested` state with the detected URL.
  ///
  /// - [url]: The URL for which an Open Graph preview is being requested.
  const FetchUrlPreviewRequested(this.url);

  @override
  List<Object?> get props => [url];
}

/// `PreviewRemoved` represents the state when an Open Graph preview has been removed.
///
/// This state is emitted when the user chooses to remove the detected URL preview
/// from the post creation process, resetting the preview state.
class PreviewRemoved extends AddPostState {}
