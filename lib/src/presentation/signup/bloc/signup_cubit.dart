import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/signup/usecases/signup_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUsecase signupUsecase;

  SignupCubit(this.signupUsecase) : super(SignupInitial());

  Future<void> signupPerformed({
    required String username,
    required String fullName,
    required String profilePictureUrl,
    String? occupation,
    String? gender,
  }) async {
    emit(SignupLoading());
    try {
      final user = await signupUsecase.execute(
        username: username,
        fullName: fullName,
        profilePictureUrl: profilePictureUrl,
        occupation: occupation,
        gender: gender,
      );
      if (user != null) {
        emit(SignupSuccess(user));
      } else {
        emit(const SignupFailure('Error : Signup failed'));
      }
    } catch (e) {
      emit(const SignupFailure('Error : Something went wrong!'));
    }
  }
}
