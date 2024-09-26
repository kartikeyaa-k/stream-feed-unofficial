import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/data/activity/datasources/activity_remote_datasource.dart';
import 'package:stream_feed_unofficial/src/data/activity/repositories/activity_repository_impl.dart';
import 'package:stream_feed_unofficial/src/data/core/datasources/auth_local_data_source.dart';
import 'package:stream_feed_unofficial/src/data/core/datasources/auth_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/data/core/interceptors/logger_interceptor.dart';
import 'package:stream_feed_unofficial/src/data/core/interceptors/token_interceptor.dart';
import 'package:stream_feed_unofficial/src/data/core/repositories/auth_repository_impl.dart';
import 'package:stream_feed_unofficial/src/data/core/utils/secure_token_storage.dart';
import 'package:stream_feed_unofficial/src/data/follow/datasources/follow_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/data/follow/repositories/follow_repository_impl.dart';
import 'package:stream_feed_unofficial/src/data/login/datasources/login_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/data/login/repositories/login_repository_impl.dart';
import 'package:stream_feed_unofficial/src/data/open_graph/datasources/open_graph_remote_datasource.dart';
import 'package:stream_feed_unofficial/src/data/open_graph/repositories/open_graph_repository_impl.dart';
import 'package:stream_feed_unofficial/src/data/signup/datasources/signup_remote_data_source.dart';
import 'package:stream_feed_unofficial/src/data/signup/repositories/signup_repository_impl.dart';
import 'package:stream_feed_unofficial/src/domain/activity/repositories/activity_repository.dart';
import 'package:stream_feed_unofficial/src/domain/core/repositories/auth_repository.dart';
import 'package:stream_feed_unofficial/src/domain/follow/repositories/follow_repository.dart';
import 'package:stream_feed_unofficial/src/domain/login/repositories/login_repository.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/repositories/open_graph_repository.dart';
import 'package:stream_feed_unofficial/src/domain/signup/repositories/signup_repository.dart';

/// `DataServiceLocator` is responsible for setting up the dependency injection for the data layer
/// of the application using the `GetIt` service locator. This class registers all data sources,
/// repositories, and related dependencies, ensuring that the data layer components are available
/// and properly configured when needed by the rest of the application.
///
/// By centralizing the registration of dependencies, `DataServiceLocator` helps maintain
/// a clean, maintainable, and testable architecture, allowing for easy management of service
/// instantiation and dependency injection.
class DataServiceLocator {
  /// Sets up the dependency injection for the data layer components.
  ///
  /// This method registers all necessary services, data sources, and repositories into the
  /// service locator (`GetIt`) instance, ensuring that each component is properly configured
  /// with its required dependencies. This setup is essential for enabling the application's
  /// data layer to function correctly and securely.
  ///
  /// Parameters:
  /// - [sl]: An instance of `GetIt` used for registering services and dependencies.
  static void setup(GetIt sl) {
    // Initialize Dio with base URL and interceptors
    sl.registerLazySingleton<Dio>(() {
      final dio =
          Dio(BaseOptions(baseUrl: sl<String>(instanceName: 'baseEndpoint')));
      dio.interceptors.addAll([sl<TokenInterceptor>(), LoggerInterceptor()]);
      return dio;
    });

    // Register SecureTokenStorage
    sl.registerLazySingleton<SecureTokenStorage>(() => SecureTokenStorage());

    // Register AuthLocalDataSource with SecureTokenStorage
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(sl<SecureTokenStorage>()),
    );

    // Register TokenInterceptor with SecureTokenStorage dependency
    sl.registerLazySingleton<TokenInterceptor>(
      () => TokenInterceptor(tokenStorage: sl<SecureTokenStorage>()),
    );

    // Data Sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        dio: sl<Dio>(),
      ),
    );

    sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(sl<Dio>()),
    );

    sl.registerLazySingleton<SignupRemoteDataSource>(
      () => SignupRemoteDataSource(sl<Dio>()),
    );

    sl.registerLazySingleton<ActivityRemoteDataSource>(
      () => ActivityRemoteDataSource(
        dio: sl<Dio>(),
        authRepository: sl<AuthRepository>(),
      ),
    );

    sl.registerLazySingleton<OpenGraphRemoteDataSource>(
      () => OpenGraphRemoteDataSource(sl<Dio>(), sl<AuthRepository>()),
    );

    sl.registerLazySingleton<FollowRemoteDataSource>(
      () => FollowRemoteDataSource(sl<Dio>()),
    );

    // Repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthLocalDataSource>()),
    );

    sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(sl<LoginRemoteDataSource>()),
    );

    sl.registerLazySingleton<SignupRepository>(
      () => SignupRepositoryImpl(sl<SignupRemoteDataSource>()),
    );

    sl.registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryImpl(sl<ActivityRemoteDataSource>()),
    );

    sl.registerLazySingleton<OpenGraphRepository>(
      () => OpenGraphRepositoryImpl(sl<OpenGraphRemoteDataSource>()),
    );

    sl.registerLazySingleton<FollowRepository>(
      () => FollowRepositoryImpl(sl<FollowRemoteDataSource>()),
    );
  }
}
