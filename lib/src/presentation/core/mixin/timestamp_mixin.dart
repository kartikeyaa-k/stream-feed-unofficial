import 'package:intl/intl.dart';

/// `TimestampMixin` provides a utility method for formatting timestamps in a user-friendly way.
/// It converts `DateTime` objects into readable strings, such as "Just now", "5 mins ago",
/// or "Jan 1, 2023", depending on how much time has passed since the given timestamp.
///
/// This mixin is designed to be used with widgets that need to display time-related information
/// in a concise and human-readable format, enhancing the user experience by presenting
/// time differences in a familiar and understandable manner.
mixin TimestampMixin {
  /// Formats the given [time] into a human-readable string that represents how long ago
  /// the event occurred relative to the current time.
  ///
  /// If [time] is null, the method returns "Just now".
  /// The formatting follows these rules:
  /// - Less than 1 minute ago: "Just now".
  /// - Less than 60 minutes ago: "{minutes} mins ago".
  /// - Less than 24 hours ago: "{hours} hours ago".
  /// - Less than 7 days ago: "{days} days ago".
  /// - Less than 30 days ago: "{weeks} weeks ago".
  /// - More than 30 days ago: the date is formatted as "MMM d, yyyy".
  ///
  /// Parameters:
  /// - [time]: The `DateTime` object representing the time to format.
  ///
  /// Returns:
  /// - A string that represents how long ago the event occurred.
  String formatTimestamp(DateTime? time) {
    if (time == null) {
      return 'Just now';
    }

    // Capture the current local time
    final nowUtc = DateTime.now().toLocal();

    // Calculate the difference between current local time and the given time
    final difference = nowUtc.difference(time.toLocal());

    // Format the timestamp difference for user-friendly display
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return DateFormat('MMM d, yyyy').format(time.toLocal());
    }
  }
}
