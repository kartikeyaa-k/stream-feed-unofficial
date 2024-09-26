part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final UserEntity user;

  const SignupSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignupFailure extends SignupState {
  final String message;

  const SignupFailure(this.message);

  @override
  List<Object?> get props => [message];
}
