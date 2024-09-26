import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/src/domain/core/entities/user_entity.dart';
import 'package:stream_feed_unofficial/src/domain/login/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  final LoginUsecase loginUseCase;

  Future<void> login(String username) async {
    emit(LoginLoading());
    try {
      final user = await loginUseCase.execute(username);
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(const LoginFailure('Error : Login failed'));
      }
    } catch (e) {
      emit(const LoginFailure('Error : Something went wrong!'));
    }
  }
}
