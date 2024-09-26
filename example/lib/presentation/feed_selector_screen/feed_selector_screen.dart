// presentation/feeds/screens/feed_selection_screen.dart
import 'package:example/utils/constants/mock_feed_selector_screen_data.dart';
import 'package:example/utils/helpers/stream_feed_helper.dart';
import 'package:flutter/material.dart';

class FeedSelectionScreen extends StatefulWidget {
  final String username;
  const FeedSelectionScreen({
    super.key,
    required this.username,
  });

  @override
  State<FeedSelectionScreen> createState() => _FeedSelectionScreenState();
}

class _FeedSelectionScreenState extends State<FeedSelectionScreen>
    with StreamFeedHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi ${widget.username}!\nLet's explore",
        ),
        centerTitle: false,
        toolbarHeight: 100,
        titleSpacing: 24,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.5,
          ),
          itemCount: mockFeedSelectorScreenDataFromBackend.length,
          itemBuilder: (context, index) {
            final feed = mockFeedSelectorScreenDataFromBackend[index];
            // hardcoded key for example purposes
            final isEnabled = feed['title'] == 'Music';

            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: isEnabled
                    ? () async {
                        await navigateToMusicStreamFeed(context);
                      }
                    : null,
                child: Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          // hardcoded key for example purposes
                          feed['image']!,
                          fit: BoxFit.cover,
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        feed['title']!,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
