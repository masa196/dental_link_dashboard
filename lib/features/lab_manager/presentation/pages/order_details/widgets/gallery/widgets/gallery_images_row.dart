import 'dart:typed_data';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class GalleryImagesRow extends StatelessWidget {
  const GalleryImagesRow({
    super.key,
    this.beforeImageUrl,
    this.afterImageUrl,
    this.beforeBytes,
    this.afterBytes,
    this.onBeforeSelected,
    this.onAfterSelected,
    this.editable = true,
  });

  final String? beforeImageUrl;
  final String? afterImageUrl;

  final Uint8List? beforeBytes;
  final Uint8List? afterBytes;

  final Function(Uint8List bytes, String name)? onBeforeSelected;
  final Function(Uint8List bytes, String name)? onAfterSelected;

  final bool editable;

  Future<void> _pickImage(BuildContext context, bool before) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result == null) return;

    final file = result.files.single;

    if (file.bytes == null) return;

    if (before) {
      onBeforeSelected?.call(file.bytes!, file.name);
    } else {
      onAfterSelected?.call(file.bytes!, file.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ImageBox(
            title: "قبل العلاج",
            bytes: beforeBytes,
            imageUrl: beforeImageUrl,
            editable: editable,
            onTap: editable ? () => _pickImage(context, true) : null,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _ImageBox(
            title: "بعد العلاج",
            bytes: afterBytes,
            imageUrl: afterImageUrl,
            editable: editable,
            onTap: editable ? () => _pickImage(context, false) : null,
          ),
        ),
      ],
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.title,
    this.bytes,
    this.imageUrl,
    this.editable = true,
    this.onTap,
  });

  final String title;
  final Uint8List? bytes;
  final String? imageUrl;
  final bool editable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (bytes != null) {
      image = Image.memory(
        bytes!,
        height: 140,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null) {
      image = Image.network(
        ApiEndpoints.resolveFileUrl(imageUrl!),
        headers: ApiEndpoints.fileHeaders,
        height: 140,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      image = const Icon(Icons.add_photo_alternate_outlined, size: 40);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),

        const SizedBox(height: 8),

        InkWell(
          onTap: editable ? onTap : null,

          borderRadius: BorderRadius.circular(16),

          child: Container(
            height: 140,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              border: Border.all(color: Theme.of(context).dividerColor),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),

              child: image,
            ),
          ),
        ),
      ],
    );
  }
}
