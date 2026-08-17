import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:flutter/material.dart';

class LabPhotoNetworkImage extends StatelessWidget {
  const LabPhotoNetworkImage({
    super.key,
    required this.photoUrl,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  final String? photoUrl;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final rawUrl = photoUrl?.trim();

    if (rawUrl == null || rawUrl.isEmpty) {
      return _PhotoFallback(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    final resolvedUrl = ApiEndpoints.resolveFileUrl(rawUrl);

    debugPrint('Lab photo raw URL: $rawUrl');
    debugPrint('Lab photo resolved URL: $resolvedUrl');

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        resolvedUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        headers: ApiEndpoints.fileHeaders,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Failed to load lab photo: $resolvedUrl');
          debugPrint('Image error: $error');

          return _PhotoFallback(
            width: width,
            height: height,
            borderRadius: borderRadius,
          );
        },
      ),
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Icon(Icons.image_outlined),
    );
  }
}
