import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';

/// `LoginRepository` defines the contract for handling user login operations within the application.
/// This interface provides a method to authenticate a user by their username and retrieve the user's
/// profile information upon successful login.
///
/// This interface should be implemented by classes responsible for managing login-related data,
/// such as remote or local data sources.
abstract class LoginRepository {
  /// Authenticates a user by their username and retrieves the associated user profile.
  ///
  /// This method performs the login operation by interacting with data sources to validate
  /// the user's credentials and fetch the user's details, encapsulated in a `UserEntity`.
  ///
  /// Parameters:
  /// - [username]: The username of the user attempting to log in.
  ///
  /// Returns:
  /// - A `Future` containing a `UserEntity` object with the user's profile information if the login
  ///   is successful, or `null` if the login fails (e.g., due to invalid credentials or user not found).
  ///
  /// Throws:
  /// - May throw exceptions related to network errors, authentication failures, or data parsing issues.
  Future<UserEntity?> login(String username);
}
