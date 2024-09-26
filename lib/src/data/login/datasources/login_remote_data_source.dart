import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_feed_unofficial/src/data/core/models/user_model.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/api_endpoint_helper.dart';

/// `LoginRemoteDataSource` is responsible for handling network operations related to user login.
/// It interacts with the backend API to authenticate users and retrieve user data.
///
/// This class uses the `Dio` package to make HTTP requests and parse the response into a
/// `UserModel`. It provides a simple and structured way to manage login requests, encapsulating
/// the complexities of network communication within a dedicated data source.
class LoginRemoteDataSource {
  final Dio dio;

  /// Constructs a `LoginRemoteDataSource` with the required `Dio` instance.
  ///
  /// - [dio]: The `Dio` client used for making network requests.
  LoginRemoteDataSource(
    this.dio,
  );

  /// Logs in a user by username and retrieves their user data from the server.
  ///
  /// This method constructs the appropriate API endpoint and query parameters to fetch the user's
  /// information, including follow counts. The response is parsed into a `UserModel`, which is
  /// used throughout the application for managing user data.
  ///

  ///
  /// Parameters:
  /// - [username]: The username of the user attempting to log in.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `UserModel` if the request is successful, or `null` if no data is found.
  ///
  /// Throws:
  /// - An `Exception` if the request fails or the response data is invalid.
  Future<UserModel?> login(String username) async {
    try {
      final path = ApiEndpoint.buildUsersUrl(
        '$username/',
      ); // TODO(Kartikeya): Replace hardcoded endpoint structure with constants or configuration.

      final query = {
        'with_follow_counts': true,
      }; // TODO(Kartikeya): Extract query parameters to a constants file or configuration.
      final response = await dio.get(
        path,
        queryParameters: query,
      );

      // Check if the response status is successful and contains data
      if ((response.statusCode == 200 || response.data == 201) &&
          response.data != null) {
        if (kDebugMode) {
          print('User Data Response: ${response.data}');
        }
        // Parse the response data to UserModel
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}
