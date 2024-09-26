import 'package:url_launcher/url_launcher.dart';

/// `UrlLauncherMixin` provides utility methods for launching URLs in the default browser.
/// This mixin is designed to be used in classes that need to handle external URL navigation,
/// making it easy to integrate URL launching functionality without duplicating code.
///
/// It checks whether the URL can be launched and handles the process of opening it
/// in the user's preferred web browser.
mixin UrlLauncherMixin {
  /// Launches the given [url] in the default browser.
  ///
  /// This method attempts to parse the given URL string and check if it can be launched.
  /// If the URL is valid and launchable, it opens the URL in the user's default browser.
  /// If the URL cannot be launched, an exception is thrown with an error message.
  ///
  /// Parameters:
  /// - [url]: A string representing the URL to be launched.
  ///
  /// Throws:
  /// - A `String` error message if the URL cannot be launched, indicating what went wrong.
  Future<void> launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(url); // Corrected method call with await.
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
