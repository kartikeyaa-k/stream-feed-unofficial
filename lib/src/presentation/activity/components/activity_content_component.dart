import 'package:flutter/material.dart';
import 'package:stream_feed_unofficial/src/presentation/core/mixin/activity_content_mixin.dart';
import 'package:stream_feed_unofficial/src/presentation/core/mixin/url_launch_helper.dart';

/// `ActivityContentComponent` is a stateless widget that displays a formatted message
/// with hyperlinks, allowing users to interact with content in a rich and dynamic way.
/// It uses the `ActivityContentMixin` for formatting the message and `UrlLauncherMixin`
/// for handling URL launches when hyperlinks are tapped.
///
/// This component is typically used within activity feeds to display post content
/// with embedded links, enhancing the user experience by making text interactive.
class ActivityContentComponent extends StatelessWidget
    with ActivityContentMixin, UrlLauncherMixin {
  final String? message;
  final List<String>? hyperlinks;

  /// Constructs an `ActivityContentComponent` with optional [message] and [hyperlinks].
  ///
  /// - [message]: The text content to be displayed, which may contain plain text or links.
  /// - [hyperlinks]: A list of URLs to be formatted within the message as clickable links.
  const ActivityContentComponent({super.key, this.message, this.hyperlinks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      // Formats the message with clickable links using the mixin method.
      child: formatMessageWithLinks(
        context, message, hyperlinks,
        // Use launchUrl from the mixin to open links.
        (url) async {
          await launchUrl(url);
        },
      ),
    );
  }
}
