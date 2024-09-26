import 'package:equatable/equatable.dart';
import 'package:example/utils/constants/mock_stream_feed_constants.dart';
import 'package:example/utils/helpers/stream_feed_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/stream_feed_unofficial.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> with StreamFeedHelper {
  /// Steam Feed Unofficial package exposes all its usecases
  /// For you to write your logic using whichever state management solution.
  final SignupUsecase signupUsecase;
  final GlobalUserFollowsCurrentUserUsecase followFeedUseCase;

  SignupCubit(
    this.signupUsecase,
    this.followFeedUseCase,
  ) : super(SignupInitial());

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
        mockCurrentUsername = username;

        /// Make global user follow current new user
        /// This is not required but just for the sake of demo purposes
        /// This should be done on the backend
        await globalUserFollowsCurrentUser(
          MockStreamFeedConstants.feedName,
          username,
        );

        emit(SignupSuccess(user));
      } else {
        emit(const SignupFailure('Error : Signup failed'));
      }
    } catch (e) {
      emit(const SignupFailure('Error : Something went wrong!'));
    }
  }

  /// Follows a target feed
  /// This is more like a workaround for demo purpose
  /// You can reach out to getStream support team,
  /// they can enable global feed for you
  Future<void> globalUserFollowsCurrentUser(
    String feedName,
    String username,
  ) async {
    try {
      /// Pass global username for this particular method
      /// as user requirement
      /// This is not the ideal way
      /// This is added just for example purposes
      await initializeGlobalUserFollowToken();
      await followFeedUseCase.execute(
        feedName: feedName,
        username: username,
        globalUsername: MockStreamFeedConstants.globalUsername,
      );

      return;
    } catch (e) {
      emit(const SignupFailure('Error : Something went wrong!'));
    }
  }
}
