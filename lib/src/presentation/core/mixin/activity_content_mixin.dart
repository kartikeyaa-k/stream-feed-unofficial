import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// `ActivityContentMixin` provides utility methods for formatting content within activities,
/// specifically focusing on enhancing text with clickable hyperlinks. This mixin is designed
/// to be used by widgets that need to display messages with interactive links, converting
/// plain text URLs into clickable elements within a `RichText` widget.
mixin ActivityContentMixin {
  /// Formats a message by replacing hyperlinks within the text with clickable text spans.
  ///
  /// This method takes a plain message string and a list of hyperlinks, then creates a
  /// `RichText` widget with the hyperlinks styled as clickable, underlined text. When tapped,
  /// these hyperlinks trigger the provided callback function, allowing for further actions such as
  /// opening URLs in a browser.
  ///
  /// Parameters:
  /// - [context]: The `BuildContext` of the widget using the mixin, used for accessing theme styles.
  /// - [message]: The message text containing the hyperlinks.
  /// - [hyperlinks]: A list of URL strings that should be recognized and formatted as clickable links.
  /// - [onTap]: A callback function that is triggered when a hyperlink is tapped, receiving the URL as a parameter.
  ///
  /// Returns:
  /// - A `RichText` widget with formatted clickable links within the message.
  ///
  /// Behavior:
  /// - If [message] or [hyperlinks] is `null`, the method returns a simple `RichText` with the message.
  /// - Hyperlinks are sorted by length in descending order to replace longer URLs first, ensuring proper formatting.
  /// - The text before and after each hyperlink is added as regular spans, while the hyperlinks are styled as clickable spans.
  RichText formatMessageWithLinks(
    BuildContext context,
    String? message,
    List<String>? hyperlinks,
    Function(String) onTap,
  ) {
    if (message == null || hyperlinks == null) {
      return RichText(
        text: TextSpan(
          text: message ?? '',
        ),
      );
    }

    // Sort hyperlinks by length in descending order to replace longer URLs first
    hyperlinks.sort((a, b) => b.length.compareTo(a.length));

    final spans = <TextSpan>[];
    var currentIndex = 0;

    // Iterate through the hyperlinks to find matches in the message
    for (final hyperlink in hyperlinks) {
      final startIndex = message.indexOf(hyperlink, currentIndex);
      if (startIndex != -1) {
        // Add text before the hyperlink as a regular span
        if (startIndex > currentIndex) {
          spans.add(
            TextSpan(
              text: message.substring(currentIndex, startIndex),
            ),
          );
        }

        // Add the hyperlink with underline and clickable
        spans.add(
          TextSpan(
            text: hyperlink,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap(hyperlink);
              },
          ),
        );

        // Update the current index to continue after the hyperlink
        currentIndex = startIndex + hyperlink.length;
      }
    }

    // Add any remaining text after the last hyperlink
    if (currentIndex < message.length) {
      spans.add(
        TextSpan(
          text: message.substring(currentIndex),
        ),
      );
    }

    return RichText(
      maxLines: 7,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: spans,
      ),
    );
  }
}
