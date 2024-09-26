import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/data/core/constants/api_constants.dart';
import 'package:stream_feed_unofficial/src/data/core/constants/token_interceptor_constants.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/secure_token_storage.dart';

/// `TokenInterceptor` is a custom Dio interceptor that dynamically attaches the appropriate
/// authentication tokens to outgoing HTTP requests based on the request type and path.
/// It distinguishes between read and write operations and retrieves the correct tokens
/// from the service locator (`GetIt`) based on the request's path.
///
/// This interceptor ensures that requests to different endpoints are authenticated correctly,
/// enabling secure communication with the backend services.
class TokenInterceptor extends Interceptor {
  final SecureTokenStorage tokenStorage;

  /// Constructs a `TokenInterceptor` with the required `SecureTokenStorage`.
  ///
  /// - [tokenStorage]: An instance of `SecureTokenStorage` used to manage token retrieval and storage.
  TokenInterceptor({required this.tokenStorage});

  /// Intercepts and modifies outgoing HTTP requests by attaching the appropriate tokens
  /// and headers based on the request type and path.
  ///
  /// This method:
  /// - Determines if the request is a read or write operation based on the HTTP method.
  /// - Adds the API key to the query parameters.
  /// - Retrieves the relevant token based on the request path (user, feed, or Open Graph).
  /// - Sets the necessary headers, including `Stream-Auth-Type`, `Authorization`, and `x-stream-client`.
  /// - Proceeds with the request even if token attachment fails, logging the error in debug mode.
  ///
  /// Parameters:
  /// - [options]: The `RequestOptions` containing details of the outgoing request.
  /// - [handler]: The `RequestInterceptorHandler` used to continue the request process.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Determine if the request is read or write based on HTTP method
      final isReadOperation =
          options.method == TokenInterceptorConstants.getRequest.toUpperCase();

      // Add API key to query parameters
      options.queryParameters.addAll({
        TokenInterceptorConstants.apiKey: GetIt.instance<String>(
          instanceName: TokenInterceptorConstants.apiKeyInstance,
        ),
      });

      String? token;

      // Attach tokens based on the request path
      if (options.path.contains(ApiConstants.usersPath)) {
        token = isReadOperation
            ? GetIt.I.get<String>(
                instanceName: TokenInterceptorConstants.userReadTokenInstance,
              )
            : GetIt.I.get<String>(
                instanceName: TokenInterceptorConstants.userWriteTokenInstance,
              );
      } else if (options.path.contains(ApiConstants.followFeed)) {
        token = GetIt.I.get<String>(
          instanceName: TokenInterceptorConstants
              .feedFollowByGlobalUserWriteTokenInstance,
        );
      } else if (options.path.contains(ApiConstants.feedPath)) {
        token = isReadOperation
            ? GetIt.I.get<String>(
                instanceName: TokenInterceptorConstants.feedReadTokenInstance,
              )
            : GetIt.I.get<String>(
                instanceName: TokenInterceptorConstants.feedWriteTokenInstance,
              );
      } else if (options.path.contains(ApiConstants.openGraphPath)) {
        token = GetIt.I.get<String>(
          instanceName: TokenInterceptorConstants.openGraphTokenInstance,
        );
      }

      // Set necessary headers for authorization and client identification
      options.headers[TokenInterceptorConstants.streamAuthTypeKey] =
          TokenInterceptorConstants.streamAuthTypeValue;
      options.headers[TokenInterceptorConstants.authorizationKey] = token;
      options.headers[TokenInterceptorConstants.xStreamClientKey] =
          TokenInterceptorConstants.xStreamClientValue;

      handler.next(options); // Proceed with the request
    } catch (e) {
      if (kDebugMode) {
        print('Error attaching token: $e');
      }
      handler.next(options); // Proceed even if token attachment fails
    }
  }
}
