part of 'auth_cubit.dart';

/// `AuthState` is an abstract class that defines the various states for the `AuthCubit`.
/// It extends `Equatable` to support state comparisons, allowing the application to
/// efficiently update the UI based on changes in the authentication state.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// `AuthInitial` represents the initial state of the `AuthCubit`.
///
/// This state is emitted when the cubit is first created and before any authentication
/// action has taken place. It serves as the default state prior to determining the user's
/// authentication status.
class AuthInitial extends AuthState {}

/// `AuthAuthenticated` represents the state when the user is successfully authenticated.
///
/// This state contains the `UserEntity` object, which holds the authenticated user's details.
/// It is emitted when the user has successfully logged in or has been recognized as authenticated.
///
/// Parameters:
/// - [user]: The `UserEntity` object representing the authenticated user.
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  /// Constructs an `AuthAuthenticated` state with the given [user].
  ///
  /// - [user]: The authenticated user's details.
  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// `AuthUnauthenticated` represents the state when the user is not authenticated.
///
/// This state is emitted when the user logs out or when the application determines that
/// the user is not currently logged in.
class AuthUnauthenticated extends AuthState {}

/// `AuthError` represents the state when an authentication error occurs.
///
/// This state contains an error message describing what went wrong during an authentication
/// operation, such as login failure or logout issues. It allows the application to provide
/// feedback to the user about authentication problems.
///
/// Parameters:
/// - [message]: A string describing the error encountered during authentication.
class AuthError extends AuthState {
  final String message;

  /// Constructs an `AuthError` state with the given error [message].
  ///
  /// - [message]: The error message detailing what went wrong.
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
