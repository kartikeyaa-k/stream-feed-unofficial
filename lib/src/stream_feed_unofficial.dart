// lib/src/get_stream_io.dart
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/data/core/constants/token_interceptor_constants.dart';
import 'package:stream_feed_unofficial/src/data/core/service_locator/data_service_locator.dart';
import 'package:stream_feed_unofficial/src/domain/core/service_locator/domain_service_locator.dart';
import 'package:stream_feed_unofficial/src/presentation/core/service_locator/presentation_service_locator.dart';

/// A class that manages the initialization and configuration of the StreamFeed
/// service. It uses the GetIt package to handle dependency injection and service
/// locators for different layers such as data, domain, and presentation.
class StreamFeed {
  /// A public constructor for the StreamFeed class.
  StreamFeed();

  /// An instance of GetIt for managing service locators.
  final GetIt _locator = GetIt.instance;

  /// Initializes the base configurations required for the StreamFeed package.
  ///
  /// This method sets up the API keys, feed names, endpoints, and authentication
  /// tokens required for accessing various StreamFeed functionalities.
  ///
  /// - [apiKey]: The API key required to authenticate with the Stream API.
  /// - [feedName]: The name of the feed that the user will interact with.
  /// - [baseEndpoint]: The base URL of the Stream API endpoint.
  /// - [userReadToken]: The token required for reading user data.
  /// - [userWriteToken]: The token required for writing user data.
  /// - [openGraphToken]: The token required for accessing Open Graph data.
  ///
  /// Throws an exception if any of the dependencies cannot be registered properly.
  Future<void> initializeBaseConfigurations({
    required String apiKey,
    required String feedName,
    required String baseEndpoint,
    required String userReadToken,
    required String userWriteToken,
    required String openGraphToken,
  }) async {
    // Registering API key and feed details with service locator
    _locator.registerSingleton<String>(
      apiKey,
      instanceName: TokenInterceptorConstants.apiKeyInstance,
    );
    _locator.registerSingleton<String>(
      feedName,
      instanceName: TokenInterceptorConstants.feedNameInstance,
    );
    _locator.registerSingleton<String>(
      baseEndpoint,
      instanceName: TokenInterceptorConstants.baseEndpointInstance,
    );

    // Registering authentication tokens with checks to avoid duplicate registrations
    if (_locator.isRegistered<String>(
      instanceName: TokenInterceptorConstants.openGraphTokenInstance,
    )) {
      _locator.unregister<String>(
        instanceName: TokenInterceptorConstants.openGraphTokenInstance,
      );
    }
    _locator.registerSingleton<String>(
      openGraphToken,
      instanceName: TokenInterceptorConstants.openGraphTokenInstance,
    );

    if (_locator.isRegistered<String>(
      instanceName: TokenInterceptorConstants.userReadTokenInstance,
    )) {
      _locator.unregister<String>(
        instanceName: TokenInterceptorConstants.userReadTokenInstance,
      );
    }
    _locator.registerSingleton<String>(
      userReadToken,
      instanceName: TokenInterceptorConstants.userReadTokenInstance,
    );

    if (_locator.isRegistered<String>(
      instanceName: TokenInterceptorConstants.userWriteTokenInstance,
    )) {
      _locator.unregister<String>(
        instanceName: TokenInterceptorConstants.userWriteTokenInstance,
      );
    }
    _locator.registerSingleton<String>(
      userWriteToken,
      instanceName: TokenInterceptorConstants.userWriteTokenInstance,
    );

    // Initialize service locators for data, domain, and presentation layers
    await _initializeModules();

    if (kDebugMode) {
      debugPrint('StreamFeed Unofficial: Initialized Locators');
    }
  }

  /// Initializes the feed configurations required for the StreamFeed package.
  ///
  /// This method sets up tokens required for reading, writing, and following feeds.
  ///
  /// - [feedReadToken]: The token required for reading feed data.
  /// - [feedWriteToken]: The token required for writing to the feed.
  /// - [feedFollowWriteToken]: The token required for following other feeds.
  ///
  /// Throws an exception if any of the dependencies cannot be registered properly.
  Future<void> initializeFeed({
    required String feedReadToken,
    required String feedWriteToken,
  }) async {
    // Registering feed tokens with checks to avoid duplicate registrations
    if (_locator.isRegistered<String>(
      instanceName: TokenInterceptorConstants.feedReadTokenInstance,
    )) {
      _locator.unregister<String>(
        instanceName: TokenInterceptorConstants.feedReadTokenInstance,
      );
    }
    _locator.registerSingleton<String>(
      feedReadToken,
      instanceName: TokenInterceptorConstants.feedReadTokenInstance,
    );

    if (_locator.isRegistered<String>(
      instanceName: TokenInterceptorConstants.feedWriteTokenInstance,
    )) {
      _locator.unregister<String>(
        instanceName: TokenInterceptorConstants.feedWriteTokenInstance,
      );
    }
    _locator.registerSingleton<String>(
      feedWriteToken,
      instanceName: TokenInterceptorConstants.feedWriteTokenInstance,
    );

    if (kDebugMode) {
      debugPrint('StreamFeed Unofficial: Initialized Feed');
    }
  }

  Future<void> initializeFollowByGlobalUserConfig({
    required String feedFollowByGlobalUserWriteToken,
  }) async {
    if (_locator.isRegistered<String>(
      instanceName:
          TokenInterceptorConstants.feedFollowByGlobalUserWriteTokenInstance,
    )) {
      _locator.unregister<String>(
        instanceName:
            TokenInterceptorConstants.feedFollowByGlobalUserWriteTokenInstance,
      );
    }
    _locator.registerSingleton<String>(
      feedFollowByGlobalUserWriteToken,
      instanceName:
          TokenInterceptorConstants.feedFollowByGlobalUserWriteTokenInstance,
    );
  }

  /// Initializes the necessary modules for the StreamFeed package.
  ///
  /// This method sets up service locators for data, domain, and presentation layers.
  Future<void> _initializeModules() async {
    DataServiceLocator.setup(_locator);
    DomainServiceLocator.setup(_locator);
    PresentationServiceLocator.setup(_locator);
  }

  /// Clears all registered service locators and resets GetIt.
  ///
  /// This method is useful when you need to completely reset the state of your
  /// application or switch between different configurations.
  Future<void> clearServiceLocators() async {
    await GetIt.I.reset();
  }
}
