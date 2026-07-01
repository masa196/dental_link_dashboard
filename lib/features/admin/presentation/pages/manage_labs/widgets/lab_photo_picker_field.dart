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
    this.onPressed,
    this.photoBytes,
    this.photoUrl,
    this.photoName,
    this.errorText,
    this.compact = false,
    this.showTitle = true,
  });

  final String title;
  final Uint8List? photoBytes;
  final String? photoUrl;
  final String? photoName;
  final String? errorText;
  final VoidCallback? onPressed;
  final bool compact;
  final bool showTitle;
  final Future<void> Function(Uint8List bytes, String fileName) onPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppTypography.fs16,
            ),
          ),
          const SizedBox(height: AppSpacing.xsPlus),
        ],
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(compact ? AppSpacing.smPlus : AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(compact ? 24 : 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _PhotoPickerTrigger(
                compact: compact,
                photoBytes: photoBytes,
                photoUrl: photoUrl,
                onPressed: () async {
                  onPressed?.call();
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
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              OutlinedButton.icon(
                onPressed: () async {
                  onPressed?.call();
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
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xsPlus),
          Text(
            errorText!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: AppTypography.fs12,
            ),
          ),
        ],
      ],
    );
  }
}

class _PhotoPickerTrigger extends StatelessWidget {
  const _PhotoPickerTrigger({
    required this.photoBytes,
    required this.photoUrl,
    required this.onPressed,
    required this.compact,
  });

  final Uint8List? photoBytes;
  final String? photoUrl;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 72.0 : 96.0;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1.2),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: ClipOval(
          child: photoBytes != null
              ? Image.memory(photoBytes!, fit: BoxFit.cover)
              : LabPhotoNetworkImage(
                  photoUrl: photoUrl,
                  width: size,
                  height: size,
                  borderRadius: size / 2,
                ),
        ),
      ),
    );
  }
}
