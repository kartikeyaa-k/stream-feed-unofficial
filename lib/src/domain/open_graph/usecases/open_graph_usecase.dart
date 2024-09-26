// lib/domain/open_graph/usecases/fetch_open_graph_usecase.dart

import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/repositories/open_graph_repository.dart';

/// `FetchOpenGraphUsecase` manages the business logic for fetching Open Graph metadata
/// from a specified URL. It acts as an intermediary between the presentation layer
/// and the `OpenGraphRepository`, ensuring that the application can retrieve and utilize
/// Open Graph data effectively for creating rich content previews.
///
/// This use case class simplifies the interaction with the repository by encapsulating
/// the logic needed to fetch and handle Open Graph data within a single method call.
class FetchOpenGraphUsecase {
  final OpenGraphRepository repository;

  /// Constructs a `FetchOpenGraphUsecase` with the provided [repository].
  ///
  /// - [repository]: The repository responsible for fetching Open Graph metadata from URLs.
  FetchOpenGraphUsecase(this.repository);

  /// Executes the use case to fetch Open Graph metadata from the given [url].
  ///
  /// This method delegates the task of retrieving Open Graph data to the repository,
  /// which parses the metadata from the specified URL. The fetched data is then
  /// returned as an `OpenGraphEntity` containing details such as the title, description,
  /// images, and other Open Graph fields.
  ///
  /// Parameters:
  /// - [url]: The URL of the web content from which Open Graph metadata should be fetched.
  ///
  /// Returns:
  /// - A `Future` containing an `OpenGraphEntity` object with the extracted metadata
  ///   if the fetch is successful, or `null` if no metadata is found or an error occurs.
  Future<OpenGraphEntity?> call(String url) {
    return repository.fetchOpenGraph(url);
  }
}
