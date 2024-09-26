import 'package:example/utils/constants/mock_stream_feed_constants.dart';
import 'package:example/utils/helpers/mock_token_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// Because conflicting file names unfortuntely
// Can be improved by refactoring names
import 'package:stream_feed_unofficial/stream_feed_unofficial.dart'
    as stream_feed_unofficial;

mixin StreamFeedHelper {
  MockTokenGenerator mockTokenGenerator = MockTokenGenerator();
  final streamFeed = GetIt.I<stream_feed_unofficial.StreamFeed>();

  Future<void> initializeStreamBaseConfigurations() async {
    await streamFeed.initializeBaseConfigurations(
      /// Ideally these values should be provided at build time
      ///
      apiKey: MockStreamFeedConstants.key,
      feedName: MockStreamFeedConstants.feedName,
      baseEndpoint: MockStreamFeedConstants.baseEndpoint,

      /// Ideally these token should be received from your backend
      ///
      userReadToken: mockTokenGenerator.getMockUserReadToken,
      userWriteToken: mockTokenGenerator.getMockUserWriteToken,
      openGraphToken: mockTokenGenerator.getMockOpenGraphToken,
    );
  }

  Future<void> initializeMusicStreamFeed() async {
    /// Ideally these tokens should be received from your backend
    ///
    await streamFeed.initializeFeed(
      feedReadToken: mockTokenGenerator.getMockFeedReadToken,
      feedWriteToken: mockTokenGenerator.getMockFeedWriteToken,
    );
  }

  /// Used right after sign up to make newly created user followed by global user
  /// This is not the ideal way
  /// This is added just for example purposes
  Future<void> initializeGlobalUserFollowToken() async {
    /// Ideally these tokens should be received from your backend
    ///
    await streamFeed.initializeFollowByGlobalUserConfig(
      feedFollowByGlobalUserWriteToken:
          mockTokenGenerator.getMockFollowFeedWriteToken,
    );
  }

  Future<void> navigateToMusicStreamFeed(BuildContext context) async {
    await initializeMusicStreamFeed();
    await initializeGlobalUserFollowToken();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => stream_feed_unofficial.LoginScreen(
              userName: mockCurrentUsername,
              feedName: MockStreamFeedConstants.feedName,
              feedAppbarTitle: MockStreamFeedConstants.feedAppBarTitle,
              isGlobalFeed: true,
              globalUsername: MockStreamFeedConstants.globalUsername,
            )));
  }

  Future<void> clearStreamFeed() async {
    await streamFeed.clearServiceLocators();
  }
}
