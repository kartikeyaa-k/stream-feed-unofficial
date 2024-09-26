import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
import 'package:stream_feed_unofficial/src/domain/activity/usecases/fetch_activity_usecase.dart';

part 'activity_state.dart';

/// `ActivityCubit` manages the state of activity (post) fetching within the application.
/// It interacts with the `FetchActivitiesUsecase` to retrieve activities from a feed and
/// handles various states such as loading, loaded, and error. It supports initial fetching,
/// loading more activities, and refreshing the feed, providing a robust state management
/// solution for displaying user or global activities.
class ActivityCubit extends Cubit<ActivityState> {
  final FetchActivitiesUsecase fetchActivitiesUsecase;
  List<ActivityEntity> _activities = [];
  bool _hasMoreActivities = true;
  bool isLoadingMore = false;

  /// Constructs an `ActivityCubit` with the given [fetchActivitiesUsecase].
  ///
  /// - [fetchActivitiesUsecase]: The use case responsible for fetching activities from a feed.
  ActivityCubit(this.fetchActivitiesUsecase) : super(ActivityInitial());

  /// Public getter to access the private [_hasMoreActivities] flag, indicating
  /// whether there are more activities to load.
  bool get hasMoreActivities => _hasMoreActivities;

  /// Fetches activities from the specified feed and updates the state accordingly.
  ///
  /// This method handles the initial load of activities, infinite scrolling (load more),
  /// and error management. It emits different states based on the result of the fetching process.
  ///
  /// Parameters:
  /// - [limit]: Optional. The maximum number of activities to retrieve. Default is 10.
  /// - [offset]: Optional. The number of activities to skip before starting to collect the result set. Default is 0.
  /// - [session]: Optional. A session identifier for tracking server-side operations.
  /// - [ranking]: Optional. Specifies the ranking algorithm to use when fetching activities.
  /// - [username]: The username of the user whose feed is being queried.
  /// - [feedName]: The name of the feed group to fetch activities from.
  ///
  /// Emits:
  /// - `ActivityLoading`: When activities are being fetched for the first time.
  /// - `ActivityLoaded`: When activities are successfully loaded.
  /// - `ActivityError`: When an error occurs during the fetch.
  Future<void> fetchActivities({
    int limit = 10,
    int offset = 0,
    String? session,
    String? ranking,
    required String username,
    required String feedName,
  }) async {
    if (offset == 0) {
      emit(ActivityLoading());
    } else {
      isLoadingMore = true; // Set loading more state
    }

    try {
      final activities = await fetchActivitiesUsecase.call(
        limit: limit,
        offset: offset,
        session: session,
        ranking: ranking,
        username: username,
        feedName: feedName,
      );

      if (offset == 0) {
        _activities = activities;
      } else {
        _activities.addAll(activities);
      }

      _hasMoreActivities = activities.length == limit;
      isLoadingMore = false; // Reset loading more state
      emit(ActivityLoaded(_activities));
    } catch (e) {
      isLoadingMore = false; // Reset loading more state
      emit(const ActivityError('Failed to fetch activities'));
    }
  }

  /// Fetches more activities to support infinite scrolling.
  ///
  /// This method checks if more activities are available and if the cubit is not
  /// currently loading more content. It appends the new activities to the existing list.
  ///
  /// Parameters:
  /// - [feedName]: The name of the feed group to fetch additional activities from.
  /// - [username]: The username of the user whose feed is being queried.
  Future<void> fetchMoreActivities(String feedName, String username) async {
    if (!_hasMoreActivities || isLoadingMore) {
      return;
    }
    await fetchActivities(
      offset: _activities.length,
      username: username,
      feedName: feedName,
    );
  }

  /// Refreshes the list of activities by re-fetching the data from the start.
  ///
  /// This method is used when a user pulls to refresh or when a full reload of
  /// activities is required. It resets the offset and fetches the latest activities.
  ///
  /// Parameters:
  /// - [username]: The username of the user whose feed is being queried.
  /// - [feedName]: The name of the feed group to fetch activities from.
  Future<void> refreshActivities(String username, String feedName) async {
    await fetchActivities(
      username: username,
      feedName: feedName,
    );
  }
}
