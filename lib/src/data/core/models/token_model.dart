import 'package:equatable/equatable.dart';

/// `Token` is a simple value object that represents an authentication or access token.
/// It extends `Equatable` to allow for easy comparisons, which is useful when managing
/// token states and checking for equality within the application.
///
/// This class encapsulates the token as a string and provides a standardized way
/// to handle tokens, ensuring consistent behavior when working with authentication data.
class Token extends Equatable {
  /// Instantiates a new [Token] with the given [token] string.
  ///
  /// - [token]: The underlying token value as a string. This could represent various types
  ///   of tokens such as authentication tokens, API access tokens, or any other type of
  ///   secure string used for authorization purposes.
  const Token(this.token);

  /// The underlying token string.
  ///
  /// This field holds the actual token value used for authentication or authorization in the application.
  final String token;

  /// Provides the properties used for equality comparison.
  ///
  /// This method ensures that two `Token` objects are considered equal if their `token`
  /// values are the same, which is particularly useful in state management scenarios
  /// where token comparisons are necessary.
  @override
  List<Object> get props => [token];

  /// Returns a string representation of the token.
  ///
  /// This method provides a way to print or log the token value directly, which can be helpful
  /// for debugging purposes. However, caution should be taken when logging sensitive information
  /// to avoid security risks.
  @override
  String toString() => token;
}
