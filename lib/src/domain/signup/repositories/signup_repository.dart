import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';

/// `SignupRepository` defines the contract for handling user signup operations within the application.
/// This interface provides a method to register a new user by collecting their profile details
/// and returning the created user's profile information upon successful signup.
///
/// This interface should be implemented by classes responsible for managing signup-related data,
/// such as remote or local data sources that interact with backend services.
abstract class SignupRepository {
  /// Registers a new user with the provided profile details.
  ///
  /// This method handles the signup process by interacting with data sources to validate
  /// the provided information, create a new user account, and fetch the user's profile details.
  /// The resulting `UserEntity` encapsulates the created user's information.
  ///
  /// Parameters:
  /// - [username]: The desired username for the new user.
  /// - [fullName]: The full name of the user.
  /// - [profilePictureUrl]: The URL of the user's profile picture.
  /// - [occupation]: Optional. The user's occupation or job title.
  /// - [gender]: Optional. The user's gender.
  ///
  /// Returns:
  /// - A `Future` containing a `UserEntity` object with the created user's profile information
  ///   if the signup is successful, or `null` if the signup fails due to validation errors or other issues.
  ///
  /// Throws:
  /// - May throw exceptions related to network errors, validation failures, or server-side issues.
  Future<UserEntity?> signup({
    required String username,
    required String fullName,
    required String profilePictureUrl,
    String? occupation,
    String? gender,
  });
}
