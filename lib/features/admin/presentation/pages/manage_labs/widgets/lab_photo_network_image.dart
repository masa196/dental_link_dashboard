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
    final url = photoUrl?.trim();

    if (url == null || url.isEmpty) {
      return _PhotoFallback(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _PhotoFallback(
          width: width,
          height: height,
          borderRadius: borderRadius,
        ),
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
