import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/signup/repositories/signup_repository.dart';

/// `SignupUsecase` manages the business logic for registering a new user in the application.
/// It acts as an intermediary between the presentation layer and the `SignupRepository`,
/// ensuring that user registration is handled correctly by delegating the signup process
/// to the repository while maintaining clean architecture principles.
///
/// This class encapsulates the signup logic, making it easy to manage user registration
/// independently of the UI and data layers.
class SignupUsecase {
  final SignupRepository repository;

  /// Constructs a `SignupUsecase` with the provided [repository].
  ///
  /// - [repository]: The repository responsible for handling signup operations.
  SignupUsecase(this.repository);

  /// Executes the signup process by calling the repository's signup method with the given profile details.
  ///
  /// This method collects the necessary user information and interacts with the `SignupRepository`
  /// to create a new user account and fetch the associated user profile details encapsulated
  /// in a `UserEntity`.
  ///
  /// Parameters:
  /// - [username]: The desired username for the new user.
  /// - [fullName]: The full name of the user.
  /// - [profilePictureUrl]: The URL of the user's profile picture.
  /// - [occupation]: Optional. The user's occupation or job title.
  /// - [gender]: Optional. The user's gender.
  ///
  /// Returns:
  /// - A `Future` containing a `UserEntity` object with the newly created user's profile information
  ///   if the signup is successful, or `null` if the signup fails due to validation errors or other issues.
  Future<UserEntity?> execute({
    required String username,
    required String fullName,
    required String profilePictureUrl,
    String? occupation,
    String? gender,
  }) {
    return repository.signup(
      username: username,
      fullName: fullName,
      profilePictureUrl: profilePictureUrl,
      occupation: occupation,
      gender: gender,
    );
  }
}
