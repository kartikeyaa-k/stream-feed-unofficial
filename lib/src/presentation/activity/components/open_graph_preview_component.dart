import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';
import 'package:stream_feed_unofficial/src/presentation/core/common_components/cached_network_image_shimmer.dart';

/// `OpenGraphPreviewComponent` is a stateless widget that displays a rich preview
/// of web content using Open Graph metadata. It shows the title, description, and image
/// of a web page, providing a visually engaging way to preview links shared within activities.
///
/// This component also supports an optional slide-to-remove action, allowing users to
/// remove the preview when the `onRemove` callback is provided.
class OpenGraphPreviewComponent extends StatelessWidget {
  final OpenGraphEntity openGraphEntity;
  final VoidCallback? onRemove;

  /// Constructs an `OpenGraphPreviewComponent` with the given [openGraphEntity] and optional [onRemove] callback.
  ///
  /// - [openGraphEntity]: The Open Graph data that contains details such as title, description, and images of the content.
  /// - [onRemove]: Optional. A callback function that is triggered when the user slides to remove the preview.
  const OpenGraphPreviewComponent({
    super.key,
    required this.openGraphEntity,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // If the Open Graph data lacks a title and description, the component will not render.
    if (openGraphEntity.title == null && openGraphEntity.description == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      child: Slidable(
        enabled: onRemove != null,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 12),
            SlidableAction(
              onPressed: (context) => onRemove!(),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Remove',
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (openGraphEntity.images?.first.image != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: CachedNetworkImageWithShimmer(
                  url: openGraphEntity.images?.first.image! ??
                      openGraphEntity.favicon ??
                      '',
                  height: 150,
                ),
              ),
            if (openGraphEntity.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  openGraphEntity.title!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            if (openGraphEntity.description != null)
              Text(
                openGraphEntity.description!,
                style: Theme.of(context).textTheme.labelSmall,
              ),
          ],
        ),
      ),
    );
  }
}
