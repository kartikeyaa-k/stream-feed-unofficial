import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';

part 'open_graph_model.g.dart';

/// `OpenGraphModel` represents the data model for Open Graph metadata retrieved from a URL.
/// This class is responsible for serializing and deserializing Open Graph data to and from JSON format,
/// and converting itself into an `OpenGraphEntity` for use in the domain layer.
///
/// It includes metadata fields such as the title, description, site name, and associated images,
/// allowing the application to display rich previews of links.
@JsonSerializable()
class OpenGraphModel extends Equatable {
  final String? duration;
  final String? title;
  final String? type;
  final String? originalUrl;
  final String? url;
  final String? siteName;
  final String? description;
  final String? favicon;
  final String? locale;
  final List<OpenGraphImageModel>? images;

  /// Creates a new instance of `OpenGraphModel`.
  ///
  /// - [duration]: The duration of the content, if applicable.
  /// - [title]: The title of the content.
  /// - [type]: The type of content (e.g., article, video).
  /// - [originalUrl]: The original URL of the content.
  /// - [url]: The URL of the Open Graph data.
  /// - [siteName]: The name of the site providing the content.
  /// - [description]: A description of the content.
  /// - [favicon]: The favicon URL associated with the site.
  /// - [locale]: The locale of the content.
  /// - [images]: A list of images associated with the content.
  const OpenGraphModel({
    this.duration,
    this.title,
    this.type,
    this.originalUrl,
    this.url,
    this.siteName,
    this.description,
    this.favicon,
    this.locale,
    this.images,
  });

  /// Creates an `OpenGraphModel` instance from a JSON map.
  ///
  /// - [json]: A map representing the Open Graph data in JSON format.
  /// - Returns: An `OpenGraphModel` object populated with data from the JSON map.
  factory OpenGraphModel.fromJson(Map<String, dynamic> json) =>
      _$OpenGraphModelFromJson(json);

  /// Converts the `OpenGraphModel` to a JSON map, suitable for serialization and storage.
  ///
  /// - Returns: A map representing the Open Graph data in JSON format.
  Map<String, dynamic> toJson() => _$OpenGraphModelToJson(this);

  /// Provides the properties used for equality comparison.
  ///
  /// This method ensures that two `OpenGraphModel` objects are considered equal if their properties are the same,
  /// which is useful for state management scenarios where Open Graph data comparisons are necessary.
  @override
  List<Object?> get props => [
        duration,
        title,
        type,
        originalUrl,
        url,
        siteName,
        description,
        favicon,
        locale,
        images,
      ];

  /// Converts `OpenGraphModel` to `OpenGraphEntity` for use in the domain layer.
  ///
  /// This conversion allows the `OpenGraphModel` to be used in business logic,
  /// ensuring that only necessary and relevant data is exposed beyond the data layer.
  ///
  /// - Returns: An `OpenGraphEntity` object containing the converted Open Graph data.
  OpenGraphEntity toEntity() {
    return OpenGraphEntity(
      duration: duration,
      title: title,
      type: type,
      originalUrl: originalUrl,
      url: url,
      siteName: siteName,
      description: description,
      favicon: favicon,
      locale: locale,
      images: images?.map((image) => image.toEntity()).toList(),
    );
  }
}

/// `OpenGraphImageModel` represents the data model for an image associated with Open Graph content.
/// It includes fields such as the image URL and its width, allowing the application to display
/// appropriate images alongside link previews.
@JsonSerializable()
class OpenGraphImageModel extends Equatable {
  final String? image;
  final int? width;

  /// Creates a new instance of `OpenGraphImageModel`.
  ///
  /// - [image]: The URL of the image.
  /// - [width]: The width of the image, if available.
  const OpenGraphImageModel({
    this.image,
    this.width,
  });

  /// Creates an `OpenGraphImageModel` instance from a JSON map.
  ///
  /// - [json]: A map representing the image data in JSON format.
  /// - Returns: An `OpenGraphImageModel` object populated with data from the JSON map.
  factory OpenGraphImageModel.fromJson(Map<String, dynamic> json) =>
      _$OpenGraphImageModelFromJson(json);

  /// Converts the `OpenGraphImageModel` to a JSON map, suitable for serialization and storage.
  ///
  /// - Returns: A map representing the image data in JSON format.
  Map<String, dynamic> toJson() => _$OpenGraphImageModelToJson(this);

  /// Provides the properties used for equality comparison.
  ///
  /// This method ensures that two `OpenGraphImageModel` objects are considered equal if their properties are the same,
  /// which is useful for state management scenarios where image data comparisons are necessary.
  @override
  List<Object?> get props => [image, width];

  /// Converts `OpenGraphImageModel` to `OpenGraphImageEntity` for use in the domain layer.
  ///
  /// This conversion allows the `OpenGraphImageModel` to be used in business logic,
  /// ensuring that only necessary and relevant image data is exposed beyond the data layer.
  ///
  /// - Returns: An `OpenGraphImageEntity` object containing the converted image data.
  OpenGraphImageEntity toEntity() {
    return OpenGraphImageEntity(
      image: image,
      width: width,
    );
  }
}
