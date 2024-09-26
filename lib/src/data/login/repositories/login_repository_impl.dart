import 'package:stream_feed_unofficial/src/data/login/datasources/login_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/login/repositories/login_repository.dart';

/// `LoginRepositoryImpl` is an implementation of the `LoginRepository` interface that
/// manages the user login process. It acts as a bridge between the domain layer and
/// the data layer, facilitating the conversion of data models to domain entities,
/// and abstracting the complexities of network operations from the rest of the application.
///
/// This class uses `LoginRemoteDataSource` to handle the actual network request
/// and subsequently converts the received data into a format that the domain layer can use.
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  /// Constructs a `LoginRepositoryImpl` with the provided `LoginRemoteDataSource`.
  ///
  /// - [remoteDataSource]: The data source responsible for making network requests
  ///   related to user login.
  LoginRepositoryImpl(this.remoteDataSource);

  /// Logs in a user by their username and retrieves the user data as a domain entity.
  ///
  /// This method calls the `login` function from `LoginRemoteDataSource` to perform the login
  /// operation. If successful, it converts the resulting `UserModel` into a `UserEntity`,
  /// making it suitable for use in the domain layer.
  ///
  /// Parameters:
  /// - [username]: The username of the user attempting to log in.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `UserEntity` if the login is successful, or `null` if
  ///   no user data is retrieved.
  @override
  Future<UserEntity?> login(String username) async {
    final userModel = await remoteDataSource.login(username);
    return userModel?.toEntity();
  }
}
