/// `LocalStorageConstants` is a utility class that defines keys used for storing
/// and retrieving data from local storage, such as shared preferences or secure storage.
///
/// These constants are primarily used as identifiers for various tokens and authentication-related
/// data, ensuring consistency across the application when accessing or manipulating local storage values.
/// While this class is intended to be used extensively in the next version of the application,
/// defining these keys in a centralized location helps maintain code organization and readability.
class LocalStorageConstants {
  /// Key used to store the main authentication token.
  static const authTokenKey = 'auth_token';

  /// Key used to store the user-specific read token.
  static const userReadTokenKey = 'user_read_token';

  /// Key used to store the user-specific write token.
  static const userWriteTokenKey = 'user_write_token';

  /// Key used to store the feed-specific read token.
  static const feedReadTokenKey = 'feed_read_token';

  /// Key used to store the feed-specific write token.
  static const feedWriteTokenKey = 'feed_write_token';

  /// Key used to store the Open Graph token.
  static const openGraphTokenKey = 'open_graph_token';
}
