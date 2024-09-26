import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/components/open_graph_preview_component.dart';
import 'package:stream_feed_unofficial/src/presentation/add_post/bloc/add_post_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/core/blocs/auth/auth_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/core/common_components/app_primary_button.dart';
import 'package:stream_feed_unofficial/src/presentation/open_graph/bloc/open_graph_cubit.dart';

/// `AddPostScreen` is a stateful widget that provides a UI for creating and posting
/// new activities (posts) to a feed. It allows users to enter text, detect URLs within
/// the content, and fetch Open Graph previews for rich content display. The screen also
/// handles user authentication checks to ensure that only logged-in users can post.
///
/// This screen manages states related to post creation and URL preview fetching using
/// `AddPostCubit` and `OpenGraphCubit`, respectively.
class AddPostScreen extends StatefulWidget {
  final String feedName;

  /// Constructs an `AddPostScreen` with the specified feed name.
  ///
  /// - [feedName]: The name of the feed to which the new post will be added.
  const AddPostScreen({
    super.key,
    required this.feedName,
  });

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  late final AddPostCubit addPostCubit;
  late final OpenGraphCubit openGraphCubit;
  late final AuthCubit authCubit;

  @override
  void initState() {
    // Initializes the cubits using dependency injection via GetIt.
    addPostCubit = GetIt.I.get<AddPostCubit>();
    openGraphCubit = GetIt.I.get<OpenGraphCubit>();
    authCubit = GetIt.I.get<AuthCubit>();
    super.initState();
  }

  /// Removes the Open Graph thumbnail preview when the user opts to discard it.
  void _removeThumbnail() {
    openGraphCubit.removePreview();
    addPostCubit.removePreview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Add Post'),
      ),
      body: BlocConsumer<AddPostCubit, AddPostState>(
        bloc: addPostCubit,
        listener: (context, addPostState) {
          if (addPostState is AddPostSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context).pop(true); // Pass true to trigger refresh
          } else if (addPostState is AddPostLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Uploading...')),
            );
          } else if (addPostState is FetchUrlPreviewRequested) {
            unawaited(openGraphCubit.fetchOpenGraphData(addPostState.url));
          }
        },
        builder: (context, addPostState) {
          return BlocConsumer<AuthCubit, AuthState>(
            bloc: authCubit,
            listener: (context, state) {},
            builder: (context, authState) {
              if (authState is AuthAuthenticated &&
                  authState.user.name != null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Text field for post content input.
                      TextField(
                        controller: _contentController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Share experiences...',
                        ),
                        onChanged: (text) {
                          addPostCubit.detectUrl(text);
                        },
                      ),
                      // Displays the Open Graph preview if available.
                      BlocBuilder<OpenGraphCubit, OpenGraphState>(
                        bloc: openGraphCubit,
                        builder: (context, state) {
                          if (state is OpenGraphLoading) {
                            return const Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 24,
                                bottom: 24,
                              ),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (state is OpenGraphPreviewFetched) {
                            return OpenGraphPreviewComponent(
                              openGraphEntity: state.openGraphData,
                              onRemove: _removeThumbnail,
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      // Button to submit the post.
                      AppPrimaryButton(
                        text: 'Post',
                        isLoading: addPostState is AddPostLoading,
                        onPressed: () {
                          if (_contentController.text.isNotEmpty) {
                            unawaited(
                              addPostCubit.addPost(
                                content: _contentController.text,
                                username: authState.user.id!,
                                userProfileImageUrl:
                                    authState.user.profileImage ?? '',
                                feedName: widget.feedName,
                                openGraphEntity: openGraphCubit.openGraphEntity,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Please login to post.'));
            },
          );
        },
      ),
    );
  }
}
