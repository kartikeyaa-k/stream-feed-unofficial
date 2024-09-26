import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/login/repositories/login_repository.dart';

/// `LoginUsecase` handles the business logic related to user login operations.
/// It serves as an intermediary between the presentation layer and the `LoginRepository`,
/// managing the process of logging in a user by their username and retrieving
/// the corresponding user profile.
///
/// This use case class is responsible for executing the login process and returning
/// the result to the calling code, ensuring that the logic remains separated
/// from the UI layer.
class LoginUsecase {
  final LoginRepository repository;

  /// Constructs a `LoginUsecase` with the provided [repository].
  ///
  /// - [repository]: The repository responsible for handling login operations.
  LoginUsecase(this.repository);

  /// Executes the login process by calling the repository's login method with the given [username].
  ///
  /// This method interacts with the `LoginRepository` to validate the user's credentials and
  /// retrieve the user's profile details encapsulated in a `UserEntity`.
  ///
  /// Parameters:
  /// - [username]: The username of the user attempting to log in.
  ///
  /// Returns:
  /// - A `Future` containing a `UserEntity` object with the user's profile information
  ///   if the login is successful, or `null` if the login fails (e.g., invalid credentials).
  Future<UserEntity?> execute(String username) {
    return repository.login(username);
  }
}
