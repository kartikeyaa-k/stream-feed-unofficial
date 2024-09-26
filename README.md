# Stream Feed Unofficial
![Your Banner](https://path-to-your-banner/banner.png)
<p align="center">
  <a href="https://github.com/kartikeyaa-k" target="_blank">
    <img src="https://img.shields.io/badge/YouTube-red?style=for-the-badge&logo=youtube&logoColor=white" alt="Github">
  </a>
  <a href="https://twitter.com/yourhandle" target="_blank">
    <img src="https://img.shields.io/badge/Twitter-blue?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter">
  </a>
  <a href="https://www.patreon.com/yourpatreon" target="_blank">
    <img src="https://img.shields.io/badge/Patreon-orange?style=for-the-badge&logo=patreon&logoColor=white" alt="Patreon">
  </a>
  <a href="https://www.buymeacoffee.com/yourlink" target="_blank">
    <img src="https://img.shields.io/badge/Buy Me A Coffee-yellow?style=for-the-badge&logo=buy-me-a-coffee&logoColor=white" alt="Buy Me A Coffee">
  </a>
</p>

**Stream Feed Unofficial** is a powerful Flutter package that integrates seamlessly with the Stream API, providing developers with the tools to build rich, modern feed-based applications effortlessly. Compatible with Flutter 3.24.2, this package is designed with scalability and maintainability in mind, following Clean Code architecture principles. It offers comprehensive support for managing activities, posts, and Open Graph data, while also allowing developers to use its core models and use cases independently to create custom UI and state management solutions.

## Key Features

- **Feed Management**: Easily create, manage, and interact with feeds using the Stream API.
- **Activity Integration**: Integrate activities seamlessly within your application for a dynamic user experience.
- **Open Graph Data Handling**: Fetch and display Open Graph data for rich content previews that enhance your feeds.
- **Dark and Light Theme Support**: Built-in support for customizable themes to match your app's branding.
- **Clean Code Architecture**: Structured with data, domain, and presentation layers to ensure code maintainability and scalability.
- **State Management**: Designed using the BLoC pattern.
- **Use Case Exposure**: Access to core usecases allows developers to implement their logic and state management framework.
- **Comprehensive Documentation**: Detailed guides and examples to get you started quickly and efficiently.


## Folder structure - designed for scalability inspired by Clean code architecture

stream_feed_unofficial/
│
├── lib/
│   ├── src/
│   │   ├── data/
│   │   │   ├── activity/
│   │   │   │   ├── datasources/
│   │   │   │   ├── models/
│   │   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── activity/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/
│   │   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── activity/
│   │   │   │   ├── bloc/
│   │   │   │   ├── components/
│   │   │   │   └── activity_list_screen.dart


## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  stream_feed_unofficial: ^0.0.1
```

## Usage
Here's a basic guide to help you get started with Stream Feed Unofficial:

Initialize the package:
Before using the package, initialize it in your app:

```dart
import 'package:stream_feed_unofficial/stream_feed_unofficial.dart';

final streamFeed = StreamFeed();

await streamFeed.initializeBaseConfigurations(
  apiKey: 'YOUR_API_KEY',
  feedName: 'YOUR_FEED_NAME',
  baseEndpoint: 'https://api.stream-io-api.com/api/',
  userReadToken: 'YOUR_USER_READ_TOKEN',
  userWriteToken: 'YOUR_USER_WRITE_TOKEN',
  openGraphToken: 'YOUR_OPEN_GRAPH_TOKEN',
);
```

Setting up the feed:

```dart
await streamFeed.initializeFeed(
  feedReadToken: 'YOUR_FEED_READ_TOKEN',
  feedWriteToken: 'YOUR_FEED_WRITE_TOKEN',
  feedFollowWriteToken: 'YOUR_FEED_FOLLOW_WRITE_TOKEN',
);

```

Directly access usecase to build your own solution

```dart
  /// Steam Feed Unofficial package exposes all its usecases
  /// For you to write your logic using whichever state management solution.
  final SignupUsecase signupUsecase;
  //
  //
  //
  final user = await signupUsecase.execute(
        username: username,
        fullName: fullName,
        profilePictureUrl: profilePictureUrl,
        occupation: occupation,
        gender: gender,
      );
   emit(SignupSuccess(user));
```

## Full Example
For a complete implementation, please refer to the example directory included in the package.

## Contributing
Contributions are welcome! Please see CONTRIBUTING.md for more details.

## Roadmap
0. Add navigation, most likely going to use auto_router.
1. Exception handling with proper message 
3. Delete post usecase 
4. Add Comments and likes
5. Handle content length and activity details screen
6. Better caching
7. Localization

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Support
For any issues or feature requests, please visit the issue tracker.