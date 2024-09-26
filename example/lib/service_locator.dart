import 'package:example/presentation/login/bloc/mock_login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:example/presentation/signup/bloc/signup_cubit.dart';
import 'package:stream_feed_unofficial/stream_feed_unofficial.dart'
    as stream_feed_uofficial;

final GetIt _locator = GetIt.instance;

void serviceLocator() {
  _locator.registerFactory<MockAuthCubit>(
    () => MockAuthCubit(),
  );

  _locator.registerLazySingleton<stream_feed_uofficial.StreamFeed>(
    () => stream_feed_uofficial.StreamFeed(),
  );

  _locator.registerFactory<SignupCubit>(
    () => SignupCubit(
      GetIt.I.get<stream_feed_uofficial.SignupUsecase>(),
      GetIt.I.get<stream_feed_uofficial.GlobalUserFollowsCurrentUserUsecase>(),
    ),
  );
}
