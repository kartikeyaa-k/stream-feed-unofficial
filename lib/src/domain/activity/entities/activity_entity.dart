// domain/activity/entities/activity_entity.dart

/// `ActivityEntity` represents an activity (post) within the domain layer.
/// It encapsulates the details of a single activity, including metadata,
/// user information, and Open Graph data for rich content previews.
class ActivityEntity {
  final String? id; // Unique identifier of the activity
  final String? actor; // The actor (user) who performed the action
  final String? verb; // The action verb (e.g., "post")
  final String? object; // The object of the action (e.g., "Post:1")
  final String? target; // The target of the action, if any
  final DateTime? time; // The time the activity occurred
  final String? message; // Message or content of the post
  final Map<String, dynamic>?
      extraData; // Additional data associated with the activity
  final String? openGraphPreviewUrl; // URL of the Open Graph preview image
  final String? openGraphPreviewTitle; // Title from the Open Graph preview
  final String? openGraphPreviewDesc; // Description from the Open Graph preview
  final List<String>? hyperlinks; // List of hyperlinks included in the post
  final Map<String, int>? reactionCounts; // Counts of reactions to the activity
  final Map<String, List<dynamic>>?
      latestReactions; // Latest reactions to the activity
  final Map<String, dynamic>?
      latestReactionsExtra; // Extra metadata for latest reactions
  final String? userProfileImageUrl; // URL of the user's profile image

  /// Constructs an `ActivityEntity` with optional parameters.
  ActivityEntity({
    this.id,
    this.actor,
    this.verb,
    this.object,
    this.target,
    this.time,
    this.message,
    this.extraData,
    this.openGraphPreviewUrl,
    this.openGraphPreviewTitle,
    this.openGraphPreviewDesc,
    this.hyperlinks,
    this.reactionCounts,
    this.latestReactions,
    this.latestReactionsExtra,
    this.userProfileImageUrl,
  });
}
