// lib/domain/open_graph/repositories/open_graph_repository.dart

import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

/// `OpenGraphRepository` defines the contract for fetching Open Graph metadata
/// from a given URL. This interface provides a method to retrieve the Open Graph
/// data associated with a URL, enabling rich previews of web content such as
/// images, titles, and descriptions.
///
/// Implementations of this interface are responsible for making network requests
/// to parse Open Graph metadata from web pages, enhancing how content is shared
/// and displayed within the application.
abstract class OpenGraphRepository {
  /// Fetches the Open Graph metadata from the specified [url].
  ///
  /// This method extracts Open Graph information from the provided URL, such as
  /// the title, description, images, and other metadata defined by the Open Graph
  /// protocol. It allows the application to create rich content previews when
  /// sharing links.
  ///
  /// Parameters:
  /// - [url]: The URL of the web content from which Open Graph metadata should be fetched.
  ///
  /// Returns:
  /// - A `Future` containing an `OpenGraphEntity` object with the extracted metadata
  ///   if the fetch is successful, or `null` if no metadata is found or an error occurs.
  ///
  /// Throws:
  /// - May throw exceptions related to network errors, invalid URLs, or parsing issues.
  Future<OpenGraphEntity?> fetchOpenGraph(String url);
}
