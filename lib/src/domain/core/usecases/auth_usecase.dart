import 'package:stream_feed_unofficial/src/domain/core/repositories/auth_repository.dart';

/// `AuthUseCase` handles the business logic related to user authentication,
/// including checking the user's authentication status and handling logout operations.
/// It acts as a mediator between the presentation layer and the `AuthRepository`,
/// ensuring that authentication-related actions are managed effectively.
class AuthUseCase {
  final AuthRepository authRepository;

  /// Constructs an `AuthUseCase` with the given [authRepository].
  ///
  /// - [authRepository]: The repository responsible for managing authentication operations.
  AuthUseCase(this.authRepository);

  /// Checks if the user is currently authenticated by retrieving the stored authentication token.
  ///
  /// This method interacts with the `AuthRepository` to determine if a user token
  /// exists, which indicates that the user is authenticated. It is often used to
  /// verify authentication status when the app is launched or when accessing protected resources.
  ///
  /// Returns:
  /// - A `Future` containing the authentication token as a `String`, or `null`
  ///   if the user is not authenticated or no token is stored.
  Future<String?> checkAuthentication() async {
    return authRepository.getToken(); // Check if a user token exists
  }

  /// Logs the user out by clearing stored authentication data through the `AuthRepository`.
  ///
  /// This method ensures that all authentication tokens are removed and any necessary
  /// cleanup actions are performed, effectively signing the user out of the application.
  /// It should be called when the user requests to log out or when session expiration occurs.
  ///
  /// Returns:
  /// - A `Future` that completes when the logout operation is finished, ensuring
  ///   that the application is in a logged-out state.
  Future<void> logout() async {
    await authRepository.logout(); // Clear user token and handle logout
  }
}
