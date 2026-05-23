import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/lab_photo_network_image.dart';

class LabPhotoPickerField extends StatelessWidget {
  const LabPhotoPickerField({
    super.key,
    required this.title,
    required this.onPicked,
    this.photoBytes,
    this.photoUrl,
    this.photoName,
  });

  final String title;
  final Uint8List? photoBytes;
  final String? photoUrl;
  final String? photoName;
  final Future<void> Function(Uint8List bytes, String fileName) onPicked;

  @override
  Widget build(BuildContext context) {
    final hasSelectedBytes = photoBytes != null;
    final hasExistingUrl = !hasSelectedBytes && photoUrl != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppTypography.fs16,
          ),
        ),
        const SizedBox(height: AppSpacing.xsPlus),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _PhotoPreview(photoBytes: photoBytes, photoUrl: photoUrl),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasSelectedBytes
                          ? (photoName ?? 'Selected photo')
                          : hasExistingUrl
                          ? 'Current photo'
                          : 'No photo selected',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            withData: true,
                          );

                          final file = result?.files.single;
                          final bytes = file?.bytes;
                          if (file == null || bytes == null) {
                            return;
                          }

                          await onPicked(bytes, file.name);
                        },
                        icon: const Icon(Icons.upload_file_outlined),
                        label: const Text('Choose Photo'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({required this.photoBytes, required this.photoUrl});

  final Uint8List? photoBytes;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final image = photoBytes != null
        ? Image.memory(photoBytes!, fit: BoxFit.cover)
        : LabPhotoNetworkImage(
            photoUrl: photoUrl,
            width: 72,
            height: 72,
            borderRadius: 12,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 72,
        height: 72,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: image,
        ),
      ),
    );
  }
}
