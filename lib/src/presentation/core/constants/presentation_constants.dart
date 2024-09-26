/// `PresentationConstants` is a utility class that holds constants used across the presentation layer of the application.
/// This class contains static constants that help maintain consistent values and configurations throughout the UI components.
///
/// It is often used for defining values like URLs, placeholder paths, and other constants that are commonly used in the presentation layer.
class PresentationConstants {
  /// A placeholder URL used when an image is not available or fails to load.
  ///
  /// This URL points to a generic placeholder image that can be used across the app
  /// whenever an image needs to be displayed but is missing or unavailable.
  /// It helps maintain the UI structure by ensuring that an empty space is not left in place of the image.
  static const String imagePlaceholder = 'https://via.placeholder.com/150';
}
