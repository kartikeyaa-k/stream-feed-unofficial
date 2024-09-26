part of 'mock_login_cubit.dart';

abstract class MockAuthState extends Equatable {
  const MockAuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends MockAuthState {}

class AuthLoading extends MockAuthState {}

class Authenticated extends MockAuthState {
  const Authenticated();

  @override
  List<Object?> get props => [];
}

class AuthError extends MockAuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
