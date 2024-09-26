import 'package:stream_feed_unofficial/src/data/core/constants/local_storage_constants.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/secure_token_storage.dart';

/// `AuthLocalDataSource` is responsible for handling the storage and retrieval of
/// authentication and access tokens using a secure storage mechanism.
/// This class interacts with `SecureTokenStorage` to manage tokens related to users, feeds, and Open Graph,
/// ensuring that sensitive information is stored securely within the application.
///
/// The methods provided by this class allow storing, retrieving, and clearing tokens as needed,
/// facilitating the management of authentication state and permissions at the data layer.
class AuthLocalDataSource {
  final SecureTokenStorage secureTokenStorage;

  /// Constructs an `AuthLocalDataSource` with the required `SecureTokenStorage` dependency.
  ///
  /// - [secureTokenStorage]: The storage mechanism used to securely store and retrieve tokens.
  AuthLocalDataSource(this.secureTokenStorage);

  // User Tokens

  /// Stores the user-specific read token in secure storage.
  ///
  /// Parameters:
  /// - [token]: The read token to be stored securely.
  Future<void> storeReadToken(String token) async {
    await secureTokenStorage.storeToken(
      LocalStorageConstants.userReadTokenKey,
      token,
    );
  }

  /// Stores the user-specific write token in secure storage.
  ///
  /// Parameters:
  /// - [token]: The write token to be stored securely.
  Future<void> storeWriteToken(String token) async {
    await secureTokenStorage.storeToken(
      LocalStorageConstants.userWriteTokenKey,
      token,
    );
  }

  /// Retrieves the user-specific read token from secure storage.
  ///
  /// Returns:
  /// - The read token, or `null` if it is not found.
  Future<String?> getReadToken() async {
    return secureTokenStorage.getToken(LocalStorageConstants.userReadTokenKey);
  }

  /// Retrieves the user-specific write token from secure storage.
  ///
  /// Returns:
  /// - The write token, or `null` if it is not found.
  Future<String?> getWriteToken() async {
    return secureTokenStorage.getToken(LocalStorageConstants.userWriteTokenKey);
  }

  /// Clears all user and feed-related tokens from secure storage.
  Future<void> clearTokens() async {
    await secureTokenStorage.clearAllTokens();
  }

  // Feed Tokens

  /// Stores the feed-specific read token in secure storage.
  ///
  /// Parameters:
  /// - [token]: The read token to be stored securely.
  Future<void> storeFeedReadToken(String token) async {
    await secureTokenStorage.storeToken(
      LocalStorageConstants.feedReadTokenKey,
      token,
    );
  }

  /// Retrieves the feed-specific read token from secure storage.
  ///
  /// Returns:
  /// - The feed read token, or `null` if it is not found.
  Future<String?> getFeedReadToken() async {
    return secureTokenStorage.getToken(LocalStorageConstants.feedReadTokenKey);
  }

  /// Stores the feed-specific write token in secure storage.
  ///
  /// Parameters:
  /// - [token]: The write token to be stored securely.
  Future<void> storeWriteFeedToken(String token) async {
    await secureTokenStorage.storeToken(
      LocalStorageConstants.feedWriteTokenKey,
      token,
    );
  }

  /// Retrieves the feed-specific write token from secure storage.
  ///
  /// Returns:
  /// - The feed write token, or `null` if it is not found.
  Future<String?> getWriteFeedToken() async {
    return secureTokenStorage.getToken(LocalStorageConstants.feedReadTokenKey);
  }

  // Open Graph Token

  /// Stores the Open Graph token in secure storage.
  ///
  /// Parameters:
  /// - [token]: The Open Graph token to be stored securely.
  Future<void> storeOpenGraphToken(String token) async {
    await secureTokenStorage.storeToken(
      LocalStorageConstants.openGraphTokenKey,
      token,
    );
  }

  /// Retrieves the Open Graph token from secure storage.
  ///
  /// Returns:
  /// - The Open Graph token, or `null` if it is not found.
  Future<String?> getOpenGraphToken() async {
    return secureTokenStorage.getToken(LocalStorageConstants.openGraphTokenKey);
  }
}
