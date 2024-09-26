part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  const SignupSuccess(this.user);
  final UserEntity user;

  @override
  List<Object?> get props => [user];
}

class SignupFailure extends SignupState {
  const SignupFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
