import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/domain/activity/usecases/add_activity_usecase.dart';
import 'package:stream_feed_unofficial/src/domain/activity/usecases/fetch_activity_usecase.dart';
import 'package:stream_feed_unofficial/src/domain/core/usecases/auth_usecase.dart';
import 'package:stream_feed_unofficial/src/domain/login/usecases/login_usecase.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/usecases/open_graph_usecase.dart';
import 'package:stream_feed_unofficial/src/domain/signup/usecases/signup_usecase.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/bloc/activity_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/add_post/bloc/add_post_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/core/blocs/auth/auth_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/login/bloc/login_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/open_graph/bloc/open_graph_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/signup/bloc/signup_cubit.dart';

/// `PresentationServiceLocator` is responsible for setting up dependency injection
/// for the presentation layer using the `GetIt` package. This class registers
/// cubits and their required dependencies, ensuring that the presentation layer
/// has access to the necessary use cases and services without tight coupling.
///
/// The service locator simplifies the management of dependencies, enabling easy access
/// to instances throughout the application and promoting a clean, maintainable architecture.
class PresentationServiceLocator {
  PresentationServiceLocator();

  /// Configures the service locator by registering cubits and their dependencies.
  ///
  /// This method sets up the dependency injection for various cubits used within
  /// the presentation layer of the application. Each cubit is registered with its
  /// corresponding use case or dependency, enabling the cubits to function correctly.
  ///
  /// Parameters:
  /// - [sl]: An instance of `GetIt` that acts as the service locator, managing the registration
  ///   and retrieval of dependencies.
  static void setup(GetIt sl) {
    // Register `AuthCubit` with a lazy singleton, injecting the `AuthUseCase`.
    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(sl<AuthUseCase>()),
    );

    // Register `LoginCubit` as a factory, injecting the `LoginUsecase`.
    sl.registerFactory<LoginCubit>(
      () => LoginCubit(sl<LoginUsecase>()),
    );

    // Register `ActivityCubit` as a factory, injecting the `FetchActivitiesUsecase`.
    sl.registerFactory<ActivityCubit>(
      () => ActivityCubit(sl<FetchActivitiesUsecase>()),
    );

    // Register `AddPostCubit` as a factory, injecting the `AddPostUsecase`.
    sl.registerFactory<AddPostCubit>(
      () => AddPostCubit(sl<AddPostUsecase>()),
    );

    // Register `OpenGraphCubit` as a factory, injecting the `FetchOpenGraphUsecase`.
    sl.registerFactory<OpenGraphCubit>(
      () => OpenGraphCubit(sl<FetchOpenGraphUsecase>()),
    );

    // Register `SignupCubit` as a factory, injecting the `SignupUsecase`.
    sl.registerFactory<SignupCubit>(
      () => SignupCubit(sl<SignupUsecase>()),
    );
  }
}
