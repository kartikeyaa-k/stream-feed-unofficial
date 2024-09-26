import 'package:stream_feed_unofficial/src/data/core/datasources/auth_local_data_source.dart';
import 'package:stream_feed_unofficial/src/domain/core/repositories/auth_repository.dart';

/// `AuthRepositoryImpl` is the implementation of the `AuthRepository` interface.
/// This class manages authentication-related operations by interacting with the data source layer,
/// specifically `AuthLocalDataSource`, to handle the storage, retrieval, and management of authentication tokens.
///
/// It abstracts the complexities of managing tokens, allowing other layers of the application
/// to perform authentication-related tasks without needing to know the details of how tokens are stored or retrieved.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  /// Constructs an `AuthRepositoryImpl` with the required `AuthLocalDataSource`.
  ///
  /// - [authLocalDataSource]: The local data source used to manage token storage and retrieval.
  AuthRepositoryImpl(this.authLocalDataSource);

  /// Retrieves the stored read token from the local data source.
  ///
  /// This method interacts with `AuthLocalDataSource` to fetch the read token, which is used
  /// for authenticating read operations within the application.
  ///
  /// Returns:
  /// - A `Future` that resolves to the read token as a `String`, or `null` if no token is found.
  @override
  Future<String?> getToken() async {
    // Use AuthLocalDataSource to retrieve the read token
    return authLocalDataSource.getReadToken();
  }

  /// Clears all stored tokens, effectively logging the user out of the application.
  ///
  /// This method calls the `clearTokens` function from `AuthLocalDataSource`, removing all
  /// stored tokens and ensuring the user is fully logged out.
  @override
  Future<void> logout() async {
    // Clear all tokens using AuthLocalDataSource
    await authLocalDataSource.clearTokens();
  }

  /// Stores both the read and write authentication tokens in the local data source.
  ///
  /// This method ensures that both the read and write tokens are securely stored,
  /// enabling the application to authenticate and perform both read and write operations.
  ///
  /// Parameters:
  /// - [readToken]: The read token to be stored.
  /// - [writeToken]: The write token to be stored.
  @override
  Future<void> storeAuthTokens(String readToken, String writeToken) async {
    // Store tokens using AuthLocalDataSource
    await authLocalDataSource.storeReadToken(readToken);
    await authLocalDataSource.storeWriteToken(writeToken);
  }

  /// Stores the feed-specific read token in the local data source.
  ///
  /// This method stores the token required for accessing feed-related read operations,
  /// allowing the application to fetch feed data securely.
  ///
  /// Parameters:
  /// - [readToken]: The feed read token to be stored.
  @override
  Future<void> storeFeedTokens(String readToken) async {
    // Store tokens using AuthLocalDataSource
    await authLocalDataSource.storeFeedReadToken(readToken);
  }

  /// Stores the feed-specific write token in the local data source.
  ///
  /// This method stores the token needed for performing write operations on the feed,
  /// such as adding or updating feed data.
  ///
  /// Parameters:
  /// - [writeToken]: The feed write token to be stored.
  @override
  Future<void> storeFeedWriteTokens(String writeToken) async {
    // Store tokens using AuthLocalDataSource
    await authLocalDataSource.storeWriteFeedToken(writeToken);
  }

  /// Stores the Open Graph token in the local data source.
  ///
  /// This method stores the token used for accessing Open Graph data, enabling the application
  /// to fetch and display Open Graph previews.
  ///
  /// Parameters:
  /// - [token]: The Open Graph token to be stored.
  @override
  Future<void> storeOpenGraphTokens(String token) async {
    // Store tokens using AuthLocalDataSource
    await authLocalDataSource.storeOpenGraphToken(token);
  }
}
