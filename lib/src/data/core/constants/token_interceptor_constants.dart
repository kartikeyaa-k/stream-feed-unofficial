/// `TokenInterceptorConstants` holds all the string constants used within the `TokenInterceptor` class.
/// This class helps in maintaining clean and readable code by centralizing the string values,
/// making it easier to manage and modify them as needed.
class TokenInterceptorConstants {
  // Request type
  static const String getRequest = 'get';
  static const String postRequest = 'post';

  // Query params
  static const String apiKey = 'api_key';

  // Header keys
  static const String streamAuthTypeKey = 'Stream-Auth-Type';
  static const String authorizationKey = 'Authorization';
  static const String xStreamClientKey = 'x-stream-client';

  // Header values
  static const String streamAuthTypeValue = 'jwt';
  static const String xStreamClientValue =
      'stream-feed-dart-client-android-0.6.0';

  // Instance names
  static const String apiKeyInstance = 'apiKey';
  static const String feedNameInstance = 'feedName';
  static const String baseEndpointInstance = 'baseEndpoint';

  static const String userReadTokenInstance = 'userReadToken';
  static const String userWriteTokenInstance = 'userWriteToken';
  static const String feedFollowByGlobalUserWriteTokenInstance =
      'feedFollowByGlobalUserWriteToken';
  static const String feedReadTokenInstance = 'feedReadToken';
  static const String feedWriteTokenInstance = 'feedWriteToken';
  static const String openGraphTokenInstance = 'openGraphToken';

  // Error messages
  static const String tokenAttachmentError = 'Error attaching token: ';
}
