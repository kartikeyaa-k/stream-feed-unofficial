import 'package:dio/dio.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/api_endpoint_helper.dart';
import 'package:stream_feed_unofficial/src/data/open_graph/models/open_graph_model.dart';
import 'package:stream_feed_unofficial/src/domain/core/repositories/auth_repository.dart';

/// `OpenGraphRemoteDataSource` is responsible for fetching Open Graph data from the backend.
/// It utilizes the `Dio` package to make HTTP requests and retrieve metadata about a given URL,
/// which is then parsed into an `OpenGraphModel`. This class handles all Open Graph-related
/// network operations, abstracting these tasks away from other layers of the application.
class OpenGraphRemoteDataSource {
  final Dio dio;
  final AuthRepository authRepository;

  /// Constructs an `OpenGraphRemoteDataSource` with the required dependencies.
  ///
  /// - [dio]: The `Dio` client used to perform network requests.
  /// - [authRepository]: The `AuthRepository` used to manage authentication-related tasks.
  OpenGraphRemoteDataSource(
    this.dio,
    this.authRepository,
  );

  /// Fetches Open Graph metadata for a given URL.
  ///
  /// This method makes a GET request to the Open Graph endpoint with the specified URL,
  /// and parses the response into an `OpenGraphModel`. It allows the application to
  /// display rich link previews by extracting metadata such as the title, description,
  /// and images associated with the URL.
  ///
  /// Parameters:
  /// - [url]: The URL for which the Open Graph metadata is to be fetched.
  ///
  /// Returns:
  /// - A `Future` that resolves to an `OpenGraphModel` containing the metadata, or `null`
  ///   if no data is retrieved.
  ///
  /// Throws:
  /// - An `Exception` if the request fails or the response is invalid.
  Future<OpenGraphModel?> fetchOpenGraph(String url) async {
    final path = ApiEndpoint
        .openGraphUrl; // TODO(Kartikeya): Replace hardcoded endpoint with a constant or configuration.
    try {
      final response = await dio.get(
        path,
        queryParameters: {'url': url},
      );

      // Check if the response status is successful and contains data
      if (response.statusCode == 200 && response.data != null) {
        return OpenGraphModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch Open Graph data');
      }
    } catch (e) {
      throw Exception('Error fetching Open Graph data: $e');
    }
  }
}
