import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/core/usecases/auth_usecase.dart';

part 'auth_state.dart';

/// `AuthCubit` manages the authentication state of the application.
/// It interacts with the `AuthUseCase` to handle user authentication and logout operations.
/// The cubit manages states such as authenticated, unauthenticated, and initial states,
/// allowing the application to respond appropriately based on the user's authentication status.
class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  /// Constructs an `AuthCubit` with the given [authUseCase].
  ///
  /// - [authUseCase]: The use case responsible for managing authentication actions such as login and logout.
  AuthCubit(this.authUseCase) : super(AuthInitial());

  /// Performs the logout operation, clearing user authentication data.
  ///
  /// This method calls the `logout` function from the `AuthUseCase`, and upon successful
  /// completion, it emits the `AuthUnauthenticated` state to signal that the user is no longer logged in.
  ///
  /// Emits:
  /// - `AuthUnauthenticated`: When the logout operation is completed successfully.
  Future<void> logoutPerformed() async {
    await authUseCase.logout();
    emit(AuthUnauthenticated());
  }

  /// Sets the user as authenticated and emits the authenticated state.
  ///
  /// This method is used to update the authentication status of the user. If a valid `UserEntity`
  /// is provided, the state is updated to `AuthAuthenticated`, which carries the user's details.
  ///
  /// Parameters:
  /// - [user]: The `UserEntity` object representing the authenticated user. If null, no state change occurs.
  ///
  /// Emits:
  /// - `AuthAuthenticated`: When a valid user is provided, indicating the user is logged in.
  Future<void> userAuthenticated(UserEntity? user) async {
    if (user != null) {
      emit(AuthAuthenticated(user));
    }
  }
}
