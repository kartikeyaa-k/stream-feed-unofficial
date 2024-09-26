import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_feed_unofficial/src/data/activity/models/feed_id_model.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/datetime_utc_helper.dart';
import 'package:stream_feed_unofficial/src/domain/activity/entities/activity_entity.dart';

part 'activity_model.g.dart';

/// `ActivityModel` is a data model that represents an activity (post) within
/// the application. It is responsible for mapping JSON data from the server
/// into a Dart object and vice versa. This model also supports conversion to
/// its corresponding entity, `ActivityEntity`, which is used within the domain layer.
///
/// This class uses the `equatable` package to enable value comparisons, and
/// `json_annotation` for JSON serialization. It also includes custom JSON
/// converters, such as `DateTimeUTCConverter`, to handle specific formatting
/// requirements like UTC DateTime serialization.
///
/// Dependencies:
/// - `equatable`: For value equality.
/// - `json_annotation`: For JSON serialization and deserialization.
/// - `FeedId`: Model used to represent feeds associated with the activity.
/// - `DateTimeUTCConverter`: Custom converter to ensure DateTime is handled in UTC.
/// - `ActivityEntity`: Domain-level entity corresponding to this model.

@JsonSerializable()
@DateTimeUTCConverter() // Custom converter for DateTime
class ActivityModel extends Equatable {
  /// Constructor for creating an `ActivityModel` with all fields.
  /// Many fields are optional, allowing for flexible instantiation.
  ///
  /// Parameters:
  /// - [actor]: The user or entity performing the activity, formatted as "User:username".
  /// - [verb]: The action being performed (e.g., "post").
  /// - [object]: The object of the action (e.g., "Post:1").
  /// - [id]: Optional. Unique identifier for the activity.
  /// - [foreignId]: Optional. Unique identifier to distinguish duplicate activities.
  /// - [target]: Optional. Specifies the target of the activity, if any.
  /// - [time]: Optional. The timestamp of the activity.
  /// - [to]: Optional. A list of feeds where this activity is sent.
  /// - [analytics]: Optional. Additional analytics data associated with the activity.
  /// - [extraContext]: Optional. Extra contextual information for the activity.
  /// - [origin]: Optional. Specifies the origin of the activity.
  /// - [score]: Optional. Score associated with the activity.
  /// - [extraData]: Optional. Any additional data relevant to the activity.
  /// - [message]: Optional. A message associated with the activity, if any.
  /// - [reactionCounts]: Optional. A map of reactions counts associated with the activity.
  /// - [latestReactions]: Optional. A map of latest reactions for the activity.
  /// - [latestReactionsExtra]: Optional. Extra metadata for the latest reactions.
  const ActivityModel({
    required this.actor,
    required this.verb,
    required this.object,
    this.id,
    this.foreignId,
    this.target,
    this.time,
    this.to,
    this.analytics,
    this.extraContext,
    this.origin,
    this.score,
    this.extraData,
    this.message,
    this.reactionCounts,
    this.latestReactions,
    this.latestReactionsExtra,
  });

  /// Factory constructor that creates an `ActivityModel` from a JSON map.
  ///
  /// - [json]: A map containing key-value pairs corresponding to the model fields.
  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  /// Converts the `ActivityModel` instance back into a JSON map.
  ///
  /// Returns:
  /// - A map representation of the `ActivityModel`, suitable for JSON encoding.
  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  // Fields representing the activity properties
  final String? id; // Unique identifier
  final String? actor; // Actor performing the action
  final String? verb; // Action verb (e.g., "post")
  final String? object; // Object of the action (e.g., "Post:1")
  final String? foreignId; // Identifier for deduplication
  final String? target; // Target of the action
  final DateTime? time; // Timestamp of the activity
  final String? origin; // Origin of the activity
  final List<FeedId>? to; // Feeds where the activity is sent
  final double? score; // Score of the activity
  final Map<String, Object>? analytics; // Analytics data
  final Map<String, Object>? extraContext; // Additional context
  final Map<String, dynamic>?
      extraData; // Extra data associated with the activity
  final String? message; // Message associated with the activity
  final Map<String, int>? reactionCounts; // Counts of reactions to the activity
  final Map<String, List<dynamic>>?
      latestReactions; // Latest reactions associated with the activity
  final Map<String, dynamic>?
      latestReactionsExtra; // Extra metadata for latest reactions

  @override
  List<Object?> get props => [
        actor,
        object,
        verb,
        target,
        to,
        foreignId,
        id,
        time,
        analytics,
        extraContext,
        origin,
        score,
        extraData,
        message,
        reactionCounts,
        latestReactions,
        latestReactionsExtra,
      ];

  /// Static constant listing the top-level fields used in the model.
  /// This can be useful for serialization and data validation.
  static const topLevelFields = [
    'actor',
    'verb',
    'object',
    'id',
    'foreign_id',
    'target',
    'time',
    'to',
    'analytics',
    'extra_context',
    'origin',
    'score',
    'extra_data',
    'message',
    'reaction_counts',
    'latest_reactions',
    'latest_reactions_extra',
  ];

  /// Converts the `ActivityModel` instance to its corresponding
  /// domain-level entity, `ActivityEntity`, which is used throughout
  /// the application’s business logic.
  ///
  /// Returns:
  /// - An `ActivityEntity` with fields mapped and formatted appropriately.
  ActivityEntity toEntity() {
    return ActivityEntity(
      id: id,
      actor:
          actor?.replaceFirst('User:', ''), // Actor formatting for domain layer
      verb: verb,
      object: object,
      target: target,
      time: time,
      message: message ?? extraData?['message'],
      extraData: extraData,
      openGraphPreviewUrl: extraData?['open_graph_preview_url'] as String?,
      openGraphPreviewTitle: extraData?['open_graph_preview_title'] as String?,
      openGraphPreviewDesc: extraData?['open_graph_preview_desc'] as String?,
      hyperlinks: (extraData?['hyperlinks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userProfileImageUrl: extraData?['user_profile_image_url'] as String?,
      reactionCounts: reactionCounts,
      latestReactions: latestReactions,
      latestReactionsExtra: latestReactionsExtra,
    );
  }
}
