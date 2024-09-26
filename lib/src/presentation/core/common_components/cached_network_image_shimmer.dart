import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// `CachedNetworkImageWithShimmer` is a stateless widget that displays a network image
/// with a shimmer effect as a placeholder while the image is loading. It uses the
/// `CachedNetworkImage` package to cache images, providing a smooth and efficient
/// user experience when displaying remote images.
///
/// This widget is ideal for scenarios where images are fetched from the network,
/// enhancing the perceived performance with a shimmer effect during loading states.
class CachedNetworkImageWithShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final int shimmerLoop;
  final Color baseColor;
  final Color highlightColor;
  final String url;

  /// Constructs a `CachedNetworkImageWithShimmer` with optional size, border radius,
  /// shimmer effect customization, and the URL of the image to be displayed.
  ///
  /// - [width]: Optional. The width of the image.
  /// - [height]: Optional. The height of the image.
  /// - [borderRadius]: Optional. The radius of the corners of the image. Default is `8`.
  /// - [shimmerLoop]: Optional. The number of times the shimmer animation loops. Default is `2`.
  /// - [baseColor]: Optional. The base color of the shimmer effect. Default is `Colors.black54`.
  /// - [highlightColor]: Optional. The highlight color of the shimmer effect. Default is `Colors.black12`.
  /// - [url]: The URL of the image to be displayed. This parameter is required.
  const CachedNetworkImageWithShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.shimmerLoop = 2,
    this.baseColor = Colors.black54,
    this.highlightColor = Colors.black12,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      // Builds the loaded image with specified dimensions and styling.
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      // Shows a shimmer effect while the image is loading.
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Theme.of(context).splashColor.withOpacity(0.5),
        highlightColor: Theme.of(context).splashColor.withOpacity(0.6),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(8),
        ),
      ),
      // Displays an error icon if the image fails to load.
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

/// `appShimmerLoader` is a linear gradient used to create a shimmer effect.
/// It provides a smooth gradient animation that mimics loading placeholders.
const appShimmerLoader = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
);
