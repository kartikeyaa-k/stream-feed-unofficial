/// `AuthRepository` defines the contract for handling authentication-related
/// operations, such as managing tokens and handling user logout. This interface
/// provides methods to store, retrieve, and clear authentication tokens, ensuring
/// that authentication flows are properly managed within the application.
///
/// This interface must be implemented by classes responsible for managing
/// authentication data, such as remote or local data sources.
abstract class AuthRepository {
  /// Retrieves the stored authentication token.
  ///
  /// This method checks the current stored authentication state and returns
  /// the token if it exists, which is typically used to authenticate requests.
  ///
  /// Returns:
  /// - A `Future` containing the authentication token as a `String`, or `null`
  ///   if no token is stored.
  Future<String?> getToken();

  /// Clears the stored authentication tokens and handles the logout process.
  ///
  /// This method should be called when the user logs out, ensuring that all
  /// authentication data is cleared and the application is in a logged-out state.
  ///
  /// Returns:
  /// - A `Future` that completes when the logout operation is finished.
  Future<void> logout();

  /// Stores the read and write tokens for authentication after a successful login.
  ///
  /// This method is typically called when a user logs in to save the necessary
  /// tokens that will be used for subsequent authenticated requests.
  ///
  /// Parameters:
  /// - [readToken]: The read token used for retrieving data.
  /// - [writeToken]: The write token used for modifying data.
  ///
  /// Returns:
  /// - A `Future` that completes when the tokens are successfully stored.
  Future<void> storeAuthTokens(String readToken, String writeToken);

  /// Stores the read token for accessing feeds.
  ///
  /// This method saves the read token specifically used for retrieving feed data,
  /// enabling the application to access user feeds securely.
  ///
  /// Parameters:
  /// - [readToken]: The token used for reading feed data.
  ///
  /// Returns:
  /// - A `Future` that completes when the token is successfully stored.
  Future<void> storeFeedTokens(String readToken);

  /// Stores the write token for modifying feeds.
  ///
  /// This method saves the write token specifically used for modifying feed data,
  /// such as adding or removing activities within feeds.
  ///
  /// Parameters:
  /// - [writeToken]: The token used for writing feed data.
  ///
  /// Returns:
  /// - A `Future` that completes when the token is successfully stored.
  Future<void> storeFeedWriteTokens(String writeToken);

  /// Stores the token for accessing Open Graph data.
  ///
  /// This method saves the token used to retrieve Open Graph data, which
  /// enriches posts with rich previews, images, and metadata.
  ///
  /// Parameters:
  /// - [token]: The token used for Open Graph data access.
  ///
  /// Returns:
  /// - A `Future` that completes when the token is successfully stored.
  Future<void> storeOpenGraphTokens(String token);
}
