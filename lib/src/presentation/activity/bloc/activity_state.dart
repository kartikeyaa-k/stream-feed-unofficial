part of 'activity_cubit.dart';

/// `ActivityState` is an abstract class that defines the various states
/// for the `ActivityCubit`. It extends `Equatable` to enable state comparisons,
/// which helps in efficiently managing UI updates based on state changes.
abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object?> get props => [];
}

/// `ActivityInitial` represents the initial state of the `ActivityCubit`.
///
/// This state is emitted when the cubit is first created and before any
/// activities have been fetched. It indicates that no data has been loaded yet.
class ActivityInitial extends ActivityState {}

/// `ActivityLoading` represents the loading state of the `ActivityCubit`.
///
/// This state is emitted when activities are being fetched from the data source.
/// It signals to the UI that data is currently being loaded, and a loading indicator
/// may be displayed to the user.
class ActivityLoading extends ActivityState {}

/// `ActivityLoaded` represents the state when activities have been successfully loaded.
///
/// This state contains a list of `ActivityEntity` objects, representing the fetched
/// activities. It is emitted when data fetching is successful, allowing the UI to
/// display the activities to the user.
///
/// Parameters:
/// - [activities]: A list of fetched activities to be displayed in the UI.
class ActivityLoaded extends ActivityState {
  final List<ActivityEntity> activities;

  /// Constructs an `ActivityLoaded` state with the given list of activities.
  ///
  /// - [activities]: The list of `ActivityEntity` objects fetched from the data source.
  const ActivityLoaded(this.activities);

  @override
  List<Object?> get props => [activities];
}

/// `ActivityError` represents the error state of the `ActivityCubit`.
///
/// This state is emitted when an error occurs during the fetching of activities.
/// It contains a message describing the error, which can be displayed to the user
/// for feedback.
///
/// Parameters:
/// - [message]: A string message describing the error encountered during data fetching.
class ActivityError extends ActivityState {
  final String message;

  /// Constructs an `ActivityError` state with the given error message.
  ///
  /// - [message]: The error message describing what went wrong during data fetching.
  const ActivityError(this.message);

  @override
  List<Object?> get props => [message];
}
