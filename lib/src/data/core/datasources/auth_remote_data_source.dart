import 'package:dio/dio.dart';
import 'package:stream_feed_unofficial/src/data/core/models/user_model.dart';

/// `AuthRemoteDataSource` is responsible for handling remote authentication-related
/// network requests using the `Dio` package. It facilitates interaction with
/// the server for authentication processes, such as refreshing tokens, by making
/// HTTP requests to the appropriate endpoints.
///
class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource({
    required this.dio,
  });

  Future<UserModel?> refreshToken(String username) async {
    try {
      /// This is not implemented yet.
      ///
      return Future.value();
    } catch (e) {
      throw Exception('Error during refreshing token: $e');
    }
  }
}
