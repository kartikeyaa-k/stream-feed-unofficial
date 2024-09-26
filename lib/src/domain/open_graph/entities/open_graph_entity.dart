// lib/domain/open_graph/entities/open_graph_entity.dart

import 'package:equatable/equatable.dart';

/// `OpenGraphEntity` represents Open Graph metadata associated with web content,
/// such as a webpage, video, or article. This metadata is used to provide rich
/// previews of shared content, including images, titles, descriptions, and more.
///
/// The Open Graph protocol enables any web page to become a rich object in a social
/// graph, making the web more connected and interactive.
class OpenGraphEntity extends Equatable {
  /// The duration of the media content, if applicable (e.g., for videos).
  final String? duration;

  /// The title of the content, used as the main heading in previews.
  final String? title;

  /// The type of the content (e.g., "article", "video", "website").
  final String? type;

  /// The original URL of the content as found in the Open Graph metadata.
  final String? originalUrl;

  /// The canonical URL of the content that the Open Graph metadata points to.
  final String? url;

  /// The name of the site hosting the content (e.g., "YouTube", "Medium").
  final String? siteName;

  /// A brief description of the content, often used in previews and social media shares.
  final String? description;

  /// URL of the favicon associated with the content, representing the site visually.
  final String? favicon;

  /// The locale of the content, indicating language and regional settings (e.g., "en_US").
  final String? locale;

  /// A list of images associated with the content, used for visual previews.
  final List<OpenGraphImageEntity>? images;

  /// Constructs an `OpenGraphEntity` with the specified metadata.
  ///
  /// Parameters:
  /// - [duration]: The duration of the media content.
  /// - [title]: The title of the content.
  /// - [type]: The type of the content.
  /// - [originalUrl]: The original URL of the content.
  /// - [url]: The canonical URL of the content.
  /// - [siteName]: The name of the site hosting the content.
  /// - [description]: A description of the content.
  /// - [favicon]: URL of the site's favicon.
  /// - [locale]: The locale of the content.
  /// - [images]: A list of images associated with the content.
  const OpenGraphEntity({
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

  /// Properties used to determine equality between instances of `OpenGraphEntity`.
  ///
  /// This is used by the `equatable` package to compare instances based on their values.
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
}

/// `OpenGraphImageEntity` represents an image object associated with Open Graph metadata.
/// These images are used in rich previews of shared content, providing visual context
/// and engagement for users.
class OpenGraphImageEntity extends Equatable {
  /// The URL of the image.
  final String? image;

  /// The width of the image, used for layout and display purposes.
  final int? width;

  /// Constructs an `OpenGraphImageEntity` with the specified image URL and width.
  ///
  /// Parameters:
  /// - [image]: The URL of the image.
  /// - [width]: The width of the image.
  const OpenGraphImageEntity({
    this.image,
    this.width,
  });

  /// Properties used to determine equality between instances of `OpenGraphImageEntity`.
  ///
  /// This is used by the `equatable` package to compare instances based on their values.
  @override
  List<Object?> get props => [image, width];
}
