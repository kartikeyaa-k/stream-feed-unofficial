import 'package:stream_feed_unofficial/src/data/open_graph/datasources/open_graph_remote_datasource.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/repositories/open_graph_repository.dart';

/// `OpenGraphRepositoryImpl` is an implementation of the `OpenGraphRepository` interface
/// that handles the retrieval of Open Graph metadata. This class acts as an intermediary between
/// the domain layer and the data layer, facilitating the conversion of data models into domain entities
/// and abstracting the complexities of network operations from the rest of the application.
///
/// This class uses `OpenGraphRemoteDataSource` to handle the actual network request and subsequently
/// converts the received data into a format that the domain layer can use.
class OpenGraphRepositoryImpl implements OpenGraphRepository {
  final OpenGraphRemoteDataSource remoteDataSource;

  /// Constructs an `OpenGraphRepositoryImpl` with the provided `OpenGraphRemoteDataSource`.
  ///
  /// - [remoteDataSource]: The data source responsible for making network requests
  ///   related to Open Graph metadata.
  OpenGraphRepositoryImpl(this.remoteDataSource);

  /// Fetches Open Graph metadata for a given URL and retrieves it as a domain entity.
  ///
  /// This method calls the `fetchOpenGraph` function from `OpenGraphRemoteDataSource`
  /// to perform the fetch operation. If successful, it converts the resulting `OpenGraphModel`
  /// into an `OpenGraphEntity`, making it suitable for use in the domain layer.
  ///
  /// Parameters:
  /// - [url]: The URL for which the Open Graph metadata is to be fetched.
  ///
  /// Returns:
  /// - A `Future` that resolves to an `OpenGraphEntity` if the fetch is successful, or `null`
  ///   if no metadata is retrieved.
  @override
  Future<OpenGraphEntity?> fetchOpenGraph(String url) async {
    final openGraphModel = await remoteDataSource.fetchOpenGraph(url);
    return openGraphModel?.toEntity();
  }
}
