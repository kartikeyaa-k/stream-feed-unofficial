// domain/service_locator/domain_service_locator.dart

import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/domain/activity/repositories/activity_repository.dart';
import 'package:stream_feed_unofficial/src/domain/core/repositories/auth_repository.dart';
import 'package:stream_feed_unofficial/src/domain/follow/repositories/follow_repository.dart';
import 'package:stream_feed_unofficial/src/domain/login/repositories/login_repository.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/repositories/open_graph_repository.dart';
import 'package:stream_feed_unofficial/src/domain/signup/repositories/signup_repository.dart';
import 'package:stream_feed_unofficial/stream_feed_unofficial.dart';

/// `DomainServiceLocator` sets up dependency injection for the domain layer
/// using the `GetIt` service locator. This class registers repositories,
/// use cases, and other services required by the domain layer.
class DomainServiceLocator {
  DomainServiceLocator();

  /// Configures and registers dependencies within the service locator.
  ///
  /// This method should be called during the app's initialization phase
  /// to ensure all required dependencies are available.
  ///
  /// - [sl]: An instance of `GetIt` where dependencies are registered.
  static void setup(GetIt sl) {
    // Register Use Cases with dependencies from the service locator
    sl.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(sl<AuthRepository>()),
    );

    sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(sl<LoginRepository>()),
    );

    sl.registerLazySingleton<SignupUsecase>(
      () => SignupUsecase(sl<SignupRepository>()),
    );

    sl.registerLazySingleton<FetchActivitiesUsecase>(
      () => FetchActivitiesUsecase(sl<ActivityRepository>()),
    );

    sl.registerLazySingleton<AddPostUsecase>(
      () => AddPostUsecase(sl<ActivityRepository>()),
    );

    sl.registerLazySingleton<FetchOpenGraphUsecase>(
      () => FetchOpenGraphUsecase(sl<OpenGraphRepository>()),
    );

    sl.registerLazySingleton<GlobalUserFollowsCurrentUserUsecase>(
      () => GlobalUserFollowsCurrentUserUsecase(sl<FollowRepository>()),
    );
  }
}
