import 'package:flutter/material.dart';
import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
import 'package:stream_feed_unofficial/src/presentation/core/common_components/cached_network_image_shimmer.dart';
import 'package:stream_feed_unofficial/src/presentation/core/constants/presentation_constants.dart';
import 'package:stream_feed_unofficial/src/presentation/core/mixin/activity_content_mixin.dart';
import 'package:stream_feed_unofficial/src/presentation/core/mixin/timestamp_mixin.dart';

/// `ActivityContentFooterComponent` is a stateless widget that displays the footer
/// of an activity (post), including user attribution, a timestamp, and an interactive
/// like button. This component enriches the content of activities by showing
/// the user who added the post, when it was added, and allowing interactions
/// through the like button.
///
/// It uses mixins for formatting timestamps and managing activity content
/// presentation, ensuring consistency in how these elements are handled across the app.
class ActivityContentFooterComponent extends StatelessWidget
    with ActivityContentMixin, TimestampMixin {
  final ActivityEntity activity;

  /// Constructs an `ActivityContentFooterComponent` with the given [activity].
  ///
  /// - [activity]: The activity (post) whose footer content is being displayed,
  ///   including user attribution, timestamp, and interactive elements.
  const ActivityContentFooterComponent({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // User Attribution with Profile Image
            CachedNetworkImageWithShimmer(
              url: activity.userProfileImageUrl ??
                  PresentationConstants.imagePlaceholder,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Displays the name of the user who added the post.
                Text(
                  'Added by ${activity.actor ?? 'User'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Displays the timestamp of when the activity was added.
                Text(
                  formatTimestamp(activity.time),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        // Like Button with Count
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Color.fromARGB(255, 223, 85, 85),
              ),
              onPressed: () {
                // Handle like button action
              },
            ),
            // Future: Like count display can be added here
          ],
        ),
      ],
    );
  }
}
