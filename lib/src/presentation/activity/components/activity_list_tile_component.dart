import 'package:flutter/material.dart';
import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/components/activity_content_component.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/components/activity_content_footer_component.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/components/open_graph_preview_component.dart';

/// `ActivityListTileComponent` is a stateless widget that displays an individual activity
/// (post) as a list tile. It includes the main content, an optional Open Graph preview,
/// and a footer with user attribution and interactive elements such as like buttons.
///
/// This component is designed to be used within lists of activities, providing a consistent
/// and visually appealing way to present each post with its associated content and actions.
class ActivityListTileComponent extends StatelessWidget {
  final ActivityEntity activity;

  /// Constructs an `ActivityListTileComponent` with the given [activity].
  ///
  /// - [activity]: The activity (post) to display, including its content,
  ///   Open Graph preview, and user interaction elements.
  const ActivityListTileComponent({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2C2C2E)
            : const Color.fromARGB(255, 233, 233, 238),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.7)
                : Colors.white.withOpacity(0.7),
            blurRadius: 8,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displays the main content of the activity with clickable hyperlinks.
          ActivityContentComponent(
            message: activity.message,
            hyperlinks: activity.hyperlinks,
          ),
          if (activity.openGraphPreviewUrl != null ||
              activity.openGraphPreviewTitle != null ||
              activity.openGraphPreviewDesc != null)
            const SizedBox(height: 8.0),
          // Displays an Open Graph preview if metadata is available.
          OpenGraphPreviewComponent(
            openGraphEntity: OpenGraphEntity(
              images: [
                OpenGraphImageEntity(image: activity.openGraphPreviewUrl),
              ],
              title: activity.openGraphPreviewTitle,
              description: activity.openGraphPreviewDesc,
            ),
            // ignore: avoid_redundant_argument_values
            onRemove: null, // Placeholder for potential remove functionality.
          ),
          const SizedBox(height: 8.0),
          // Footer containing user attribution and interaction elements.
          ActivityContentFooterComponent(activity: activity),
        ],
      ),
    );
  }
}
