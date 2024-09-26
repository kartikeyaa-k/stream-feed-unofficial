import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_feed_unofficial/src/data/core/models/user_model.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/api_endpoint_helper.dart';

/// `SignupRemoteDataSource` is responsible for handling network operations related to user signup.
/// It uses the `Dio` package to make HTTP requests to the backend API, allowing new users to be
/// created and their information to be retrieved.
///
/// This class manages the signup process, including sending user details to the server and
/// parsing the server's response into a `UserModel` that can be used within the application.
class SignupRemoteDataSource {
  final Dio dio;

  /// Constructs a `SignupRemoteDataSource` with the required `Dio` instance.
  ///
  /// - [dio]: The `Dio` client used for making network requests.
  SignupRemoteDataSource(
    this.dio,
  );

  /// Signs up a new user by sending their details to the backend and retrieving their user data.
  ///
  /// This method constructs the appropriate API endpoint and request body to create or fetch
  /// the user, including optional fields like occupation and gender. The response is parsed into
  /// a `UserModel`, which can then be used within the application.
  ///
  // TODO(Kartikeya): Refactor to remove hardcoded strings and replace them with constants for maintainability.
  ///
  /// Parameters:
  /// - [username]: The username of the user being signed up.
  /// - [fullName]: The full name of the user.
  /// - [profilePictureUrl]: The URL of the user's profile picture.
  /// - [occupation]: (Optional) The user's occupation.
  /// - [gender]: (Optional) The user's gender.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `UserModel` if the signup is successful, or `null` if no data is found.
  ///
  /// Throws:
  /// - An `Exception` if the signup request fails or the response data is invalid.
  Future<UserModel?> signup({
    required String username,
    required String fullName,
    required String profilePictureUrl,
    String? occupation,
    String? gender,
  }) async {
    try {
      final path = ApiEndpoint
          .buildUsersUrl(); // TODO(Kartikeya): Replace hardcoded endpoint with a constant or configuration.

      final response = await dio.post(
        path,
        queryParameters: {
          'get_or_create': true,
        }, // TODO(Kartikeya): Extract query parameters to a constants file or configuration.
        data: {
          'id': username,
          'data': {
            'name': fullName,
            'occupation': occupation,
            'gender': gender,
            'profileImage': profilePictureUrl,
          },
        },
      );

      // Check if the response status is successful and contains data
      if ((response.statusCode == 200 || response.statusCode == 201) &&
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
      throw Exception('Error during signup: $e');
    }
  }
}
