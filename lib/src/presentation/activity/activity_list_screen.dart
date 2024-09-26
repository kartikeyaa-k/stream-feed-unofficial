import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/bloc/activity_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/components/activity_list_tile_component.dart';
import 'package:stream_feed_unofficial/src/presentation/add_post/add_post_screen.dart';
import 'package:stream_feed_unofficial/src/presentation/core/blocs/auth/auth_cubit.dart';

/// `ActivityListScreen` is a stateful widget that displays a list of activities (posts)
/// for a specific feed. It manages loading, refreshing, and infinite scrolling of activities,
/// allowing users to see content and add new posts to their feed.
class ActivityListScreen extends StatefulWidget {
  const ActivityListScreen({
    super.key,
    required this.feedName,
    required this.appbarTitle,
    this.isGlobalFeed = false,
    this.globalUsername = 'global',
  });

  /// Constructs an `ActivityListScreen` with the given feed parameters.
  ///
  /// - [feedName]: The name of the feed to display activities from.
  /// - [appbarTitle]: The title of the app bar for this screen.
  /// - [isGlobalFeed]: Optional. Indicates if the feed is global. Default is `false`.
  /// - [globalUsername]: Optional. The username used for global feeds. Default is `'global'`.
  final String feedName;
  final String appbarTitle;
  final bool isGlobalFeed;
  final String globalUsername;

  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  late final ActivityCubit activityCubit;
  late final AuthCubit authCubit;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  UserEntity? userEntity;
  late String feedUsername;

  @override
  void initState() {
    activityCubit = GetIt.I.get<ActivityCubit>();
    authCubit = GetIt.I.get<AuthCubit>();
    feedUsername = widget.globalUsername;

    if (authCubit.state is AuthAuthenticated) {
      final authState = authCubit.state as AuthAuthenticated;
      userEntity = authState.user;
      if (userEntity != null && userEntity!.id != null) {
        feedUsername =
            widget.isGlobalFeed ? widget.globalUsername : userEntity!.id!;
      }
    }
    _scrollController.addListener(_onScroll);
    unawaited(_fetchInitialActivities());
    super.initState();
  }

  /// Fetches the initial set of activities for the specified feed.
  ///
  /// This method is called during the initialization phase to load the first batch
  /// of activities, ensuring that the feed content is displayed when the screen is first shown.
  Future<void> _fetchInitialActivities() async {
    if (userEntity != null && userEntity?.id != null) {
      await activityCubit.fetchActivities(
        feedName: widget.feedName,
        username: feedUsername,
      );
    }
  }

  /// Handles scroll events to load more activities when reaching near the bottom of the list.
  ///
  /// This listener checks if the user has scrolled near the bottom of the content and if
  /// more activities are available, triggering a fetch for additional content.
  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        activityCubit.hasMoreActivities) {
      unawaited(_loadMoreActivities());
    }
  }

  /// Loads more activities for the feed when the user scrolls to the bottom.
  ///
  /// This method helps to implement infinite scrolling by loading additional
  /// activities as the user reaches the end of the currently loaded list.
  Future<void> _loadMoreActivities() async {
    _isLoadingMore = true;
    if (userEntity != null && userEntity?.id != null) {
      await activityCubit.fetchMoreActivities(
        widget.feedName,
        feedUsername,
      );
    }
    _isLoadingMore = false;
  }

  /// Refreshes the activity list when the user performs a pull-to-refresh action.
  ///
  /// This method re-fetches the activities from the beginning, allowing the user
  /// to see the latest content by pulling down on the list.
  Future<void> _onRefresh() async {
    if (userEntity != null && userEntity?.id != null) {
      await activityCubit.fetchActivities(
        feedName: widget.feedName,
        username: feedUsername,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.appbarTitle),
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        bloc: activityCubit,
        builder: (context, state) {
          if (state is ActivityLoading && !_isLoadingMore) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ActivityLoaded) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                controller: _scrollController,
                itemCount: state.activities.length,
                itemBuilder: (context, index) {
                  return ActivityListTileComponent(
                    activity: state.activities[index],
                  );
                },
              ),
            );
          } else if (state is ActivityError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No activities found.'));
          }
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddPostScreen(feedName: widget.feedName),
            ),
          );
          if (result == true) {
            await _onRefresh();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
