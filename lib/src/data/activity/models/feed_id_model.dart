import 'package:equatable/equatable.dart';

/// Represents a feed identifier combining a feed group [slug] and a [userId].
///
/// The `FeedId` class is used to uniquely identify feeds in the application,
/// such as user feeds, trending feeds, or other custom feed types.
/// It ensures that the identifiers are correctly formatted and validated.
class FeedId extends Equatable {
  /// Constructs a [FeedId] using the [slug] (feed group) and [userId] (owner).
  ///
  /// - [slug]: The feed group, e.g., "user" or "timeline".
  /// - [userId]: The unique identifier of the user or entity owning the feed.
  ///
  /// Throws:
  /// - An `AssertionError` if [slug] or [userId] contains invalid characters, such as ':'.
  FeedId(this.slug, this.userId)
      : assert(!slug.contains(':'), 'Invalid slug'), // Ensures no ':' in slug
        assert(
          !userId.contains(':'),
          'Invalid userId',
        ); // Ensures no ':' in userId

  /// Creates a [FeedId] from a combined [id] string in the format "slug:userId".
  ///
  /// This factory method splits the [id] into its [slug] and [userId] components.
  ///
  /// Throws:
  /// - An `AssertionError` if the [id] format is invalid or does not contain exactly one ':'.
  factory FeedId.id(String id) {
    assert(id.contains(':'), 'Invalid FeedId'); // Ensures ':' is present in id
    final parts = id.split(':');
    assert(
      parts.length == 2,
      'Invalid FeedId',
    ); // Ensures the id splits into exactly two parts
    return FeedId(parts[0], parts[1]);
  }

  /// The name of the feed group, such as "user" or "flat".
  /// Commonly used groups include `user`, `timeline`, `notifications`.
  final String slug;

  /// The owner or user identifier associated with the feed.
  /// Typically, this is the unique user ID or another identifier relevant to the feed's owner.
  final String userId;

  /// Generates a claim string used in feed queries by concatenating [slug] and [userId].
  String get claim => '$slug$userId';

  /// Returns the feed identifier in the format "slug:userId", used for following and feed interactions.
  String get followClaim => '$slug:$userId';

  /// Converts a list of string IDs (in "slug:userId" format) to a list of [FeedId] objects.
  ///
  /// - [ids]: A list of string feed IDs.
  ///
  /// Returns:
  /// - A list of [FeedId] instances created from the input list, or null if input is null.
  static List<FeedId>? fromIds(List? ids) =>
      ids?.map((e) => FeedId.id(e)).toList(growable: false);

  /// Converts a list of [FeedId] objects to their string representation ("slug:userId").
  ///
  /// - [feeds]: A list of [FeedId] objects.
  ///
  /// Returns:
  /// - A list of strings representing each feed, or null if input is null.
  static List<String>? toIds(List<FeedId>? feeds) =>
      feeds?.map((e) => e.toString()).toList(growable: false);

  /// Creates a [FeedId] from a single string ID in "slug:userId" format.
  ///
  /// - [id]: A string representation of the feed ID.
  ///
  /// Returns:
  /// - A [FeedId] instance or null if the input is null.
  static FeedId? fromId(String? id) {
    if (id == null) {
      return null;
    }
    return FeedId.id(id);
  }

  /// Converts a [FeedId] to its string representation ("slug:userId").
  ///
  /// - [feedId]: A [FeedId] instance.
  ///
  /// Returns:
  /// - A string representation of the feed ID or null if input is null.
  static String? toId(FeedId? feedId) => feedId?.toString();

  @override
  List<Object> get props =>
      [slug, userId]; // Used for value comparison with equatable.

  /// Returns the string representation of the feed identifier in "slug:userId" format.
  @override
  String toString() => '$slug:$userId';
}
