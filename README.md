# Stream Feed Unofficial
![Untitled-2](https://github.com/user-attachments/assets/7d6b86ef-7932-464a-b255-93a13489a81d)

<p align="center">
  <a href="https://github.com/kartikeyaa-k" target="_blank">
    <img src="https://img.shields.io/badge/Github-black?style=for-the-badge&logo=github&logoColor=white" alt="Github">
  </a>
  <a href="mailto:kartikeya.199231@gmail.com" target="_blank">
    <img src="https://img.shields.io/badge/Say%20Hi-F8D977?style=for-the-badge&color=orange" alt="Mail">
  </a>
  <a href="http://linkedin.com/in/kartikeya31/" target="_blank">
    <img src="https://img.shields.io/badge/linkedin-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
  </a>
  <a href="https://www.buymeacoffee.com/yourlink" target="_blank">
    <img src="https://img.shields.io/badge/Buy%20Me%20A%20Coffee-yellow?style=for-the-badge&logo=buy-me-a-coffee&logoColor=white&color=purple" alt="Buy Me A Coffee">
  </a>
  <a href="http://kartikeyabadekar.com" target="_blank">
    <img src="https://img.shields.io/badge/Website-F8D977?style=for-the-badge" alt="Website">
  </a>
</p>

**Stream Feed Unofficial** is a powerful Flutter package that integrates seamlessly with the getstream.io API, providing developers with the tools to build rich, modern feed-based applications effortlessly. Compatible with Flutter 3.24.2, this package is designed with scalability and maintainability in mind, following Clean Code architecture principles. It offers comprehensive support for managing activities, posts, and Open Graph data, while also allowing developers to use its core models and use cases independently to create custom UI and state management solutions.

> **Note:** This package is still evolving and is currently less feature-rich compared to the official [stream_feed](https://pub.dev/packages/stream_feed) package. However, it is compatible with the latest Flutter versions 3.24.x. If you need all the features of Stream's API, you may want to consider using the official package, though it may not support the latest Flutter updates.


## Key Features

- **Clean Code Architecture**: Structured with data, domain, and presentation layers to ensure code maintainability and scalability.
- **Use Case Exposure**: Access to core usecases allows developers to implement their logic and state management framework.
- **Feed Management**: Easily create, manage, and interact with feeds using the Stream API.
- **Activity Integration**: Integrate activities seamlessly within your application for a dynamic user experience.
- **Open Graph Data Handling**: Fetch and display Open Graph data for rich content previews that enhance your feeds.
- **Dark and Light Theme Support**: Built-in support for customizable themes to match your app's branding.
- **State Management**: Designed using the BLoC pattern.
- **Comprehensive Documentation**: Detailed guides and examples to get you started quickly and efficiently.


## Designed for scalability inspired by Clean code architecture
```
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

```
## Preview 
<a href="https://www.kartikeyabadekar.com/visuals#stream-feed-unofficial-video">Watch example video</a>
<div style="display: flex; justify-content: center; gap: 10px;">
  <img src="https://github.com/user-attachments/assets/5b7ccbd2-8005-41e2-98e0-1c4beca01f3a" alt="Image 1" style="height: 440px; width: auto; object-fit: cover;">
  <img src="https://github.com/user-attachments/assets/15a86ade-579f-4527-b164-70293518e574" alt="Image 2" style="height: 440px; width: auto; object-fit: cover;">
  <img src="https://github.com/user-attachments/assets/d316fe62-b286-48ff-a39a-a6386d82e78b" alt="Image 3" style="height: 440px; width: auto; object-fit: cover;">
  <img src="https://github.com/user-attachments/assets/06e5deda-3bca-480a-932f-2d6765d28890" alt="Image 3" style="height: 440px; width: auto; object-fit: cover;">
</div>



## Getting Started

### Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  stream_feed_unofficial: ^0.0.1
```

## Usage
Here's a basic guide to help you get started with Stream Feed Unofficial:

Dependency registration as per your requirements
```dart
_locator.registerLazySingleton<StreamFeed>(
    () => StreamFeed(),
  );
```

```dart
await streamFeed.initializeBaseConfigurations(
  apiKey: 'YOUR_API_KEY',
  feedName: 'YOUR_FEED_NAME',
  baseEndpoint: 'https://[appRegion]-api.stream-io-api.com/api/',
  userReadToken: 'YOUR_USER_READ_TOKEN',
  userWriteToken: 'YOUR_USER_WRITE_TOKEN',
  openGraphToken: 'YOUR_OPEN_GRAPH_TOKEN',
);
```

```dart
await streamFeed.initializeFeed(
  feedReadToken: 'YOUR_FEED_READ_TOKEN',
  feedWriteToken: 'YOUR_FEED_WRITE_TOKEN',
  feedFollowWriteToken: 'YOUR_FEED_FOLLOW_WRITE_TOKEN',
);

```

Directly access usecase to build your own solution for state management

```dart
  /// Steam Feed Unofficial package exposes all its usecases
  /// For you to write your logic using whichever state management solution.
  final SignupUsecase signupUsecase;
  ...
  ...
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
8. Create separate packages for Data, Domain, and Presentation layers. 

...To be continued

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Support
For any issues or feature requests, please visit the issue tracker - https://github.com/kartikeyaa-k/stream-feed-unofficial/issues
