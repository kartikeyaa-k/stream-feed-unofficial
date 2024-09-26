import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'mock_login_state.dart';

class MockAuthCubit extends Cubit<MockAuthState> {
  MockAuthCubit() : super(AuthInitial());

  Future<void> performedMockAuthentication() async {
    emit(AuthLoading());
    try {
      Future.delayed(const Duration(seconds: 1), () {
        emit(const Authenticated());
      });
    } catch (e) {
      emit(const AuthError('Failed to generate tokens'));
    }
  }
}
