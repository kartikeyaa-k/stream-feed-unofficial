import 'package:stream_feed_unofficial/src/data/signup/datasources/signup_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/signup/repositories/signup_repository.dart';

/// `SignupRepositoryImpl` is an implementation of the `SignupRepository` interface
/// that handles the user signup process. It acts as a bridge between the domain layer
/// and the data layer, facilitating the conversion of data models into domain entities
/// and abstracting the complexities of network operations from the rest of the application.
///
/// This class uses `SignupRemoteDataSource` to handle the actual network request and
/// subsequently converts the received data into a format that the domain layer can use.
class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remoteDataSource;

  /// Constructs a `SignupRepositoryImpl` with the provided `SignupRemoteDataSource`.
  ///
  /// - [remoteDataSource]: The data source responsible for making network requests
  ///   related to user signup.
  SignupRepositoryImpl(this.remoteDataSource);

  /// Signs up a new user by sending their details to the backend and retrieves the user data as a domain entity.
  ///
  /// This method calls the `signup` function from `SignupRemoteDataSource` to perform the signup operation.
  /// If successful, it converts the resulting `UserModel` into a `UserEntity`, making it suitable for use in the domain layer.
  ///
  /// Parameters:
  /// - [username]: The username of the user being signed up.
  /// - [fullName]: The full name of the user.
  /// - [profilePictureUrl]: The URL of the user's profile picture.
  /// - [occupation]: (Optional) The user's occupation.
  /// - [gender]: (Optional) The user's gender.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `UserEntity` if the signup is successful, or `null` if
  ///   no user data is retrieved.
  @override
  Future<UserEntity?> signup({
    required String username,
    required String fullName,
    required String profilePictureUrl,
    String? occupation,
    String? gender,
  }) async {
    final userModel = await remoteDataSource.signup(
      username: username,
      fullName: fullName,
      profilePictureUrl: profilePictureUrl,
      occupation: occupation,
      gender: gender,
    );
    return userModel?.toEntity();
  }
}
