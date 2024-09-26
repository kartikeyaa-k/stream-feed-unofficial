import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// `LoggerInterceptor` is a custom interceptor for the Dio HTTP client that logs
/// request, response, and error information. It uses the `Logger` package to provide
/// detailed insights into the HTTP traffic within the application, making it easier
/// to debug and monitor API interactions.
///
/// This interceptor can be attached to a Dio instance to automatically log every
/// HTTP request made, including request headers, data, and response details, helping
/// developers trace and understand the application's network behavior.
class LoggerInterceptor extends Interceptor {
  final Logger logger = Logger();

  /// Intercepts and logs details of the outgoing HTTP request.
  ///
  /// This method captures the request method, URL, headers, data, and query parameters,
  /// providing detailed information about what is being sent to the server.
  ///
  /// Parameters:
  /// - [options]: The `RequestOptions` containing details of the HTTP request.
  /// - [handler]: The `RequestInterceptorHandler` used to continue the request process.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('REQUEST[${options.method}] => URL: ${options.uri}');
    logger.i('Headers: ${options.headers}');
    if (options.data != null) {
      logger.i('Data: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      logger.i('Query Parameters: ${options.queryParameters}');
    }
    super.onRequest(options, handler);
  }

  /// Intercepts and logs details of the incoming HTTP response.
  ///
  /// This method captures the response status code, URL, and data, providing insights
  /// into the server's response, which is essential for debugging and monitoring the success
  /// of API requests.
  ///
  /// Parameters:
  /// - [response]: The `Response` object containing the server's response data.
  /// - [handler]: The `ResponseInterceptorHandler` used to continue the response process.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
      'RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.uri}',
    );
    logger.i('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  /// Intercepts and logs details of any errors that occur during the HTTP request or response.
  ///
  /// This method captures error status codes, messages, and response data, providing valuable
  /// information for diagnosing issues with network requests.
  ///
  /// Parameters:
  /// - [err]: The `DioError` containing details of the error encountered.
  /// - [handler]: The `ErrorInterceptorHandler` used to handle the error.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      'ERROR[${err.response?.statusCode}] => URL: ${err.requestOptions.uri}',
    );
    logger.e('Error: ${err.message}');
    if (err.response?.data != null) {
      logger.e('Response Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
