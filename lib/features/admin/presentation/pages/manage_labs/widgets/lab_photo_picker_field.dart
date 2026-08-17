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
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppTypography.fs16,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xsPlus),
        ],

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? AppSpacing.sm : AppSpacing.md,
            vertical: compact ? AppSpacing.sm : AppSpacing.smPlus,
          ),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(
              compact ? 20 : 16,
            ),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.65),
            ),
          ),
          child: Row(
            children: [
              // -------------------------------------------------------------
              // PHOTO PREVIEW
              // -------------------------------------------------------------
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

              const SizedBox(width: AppSpacing.md),

              // -------------------------------------------------------------
              // PHOTO INFORMATION
              // -------------------------------------------------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      photoName ?? title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTypography.fs14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      photoName != null
                          ? 'Photo selected'
                          : 'Upload a photo for the lab',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppTypography.fs12,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // -------------------------------------------------------------
              // CHOOSE PHOTO
              // -------------------------------------------------------------
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
                icon: const Icon(
                  Icons.upload_file_outlined,
                  size: 18,
                ),
                label: const Text('Choose Photo'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  minimumSize: const Size(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(
                    color: scheme.outlineVariant,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xsPlus),
          Text(
            errorText!,
            style: TextStyle(
              color: scheme.error,
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
    final scheme = Theme.of(context).colorScheme;

    // Smaller and more balanced than the previous 96px circle.
    final size = compact ? 60.0 : 72.0;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheme.surface,
          border: Border.all(
            color: scheme.outlineVariant,
            width: 1.2,
          ),
        ),
        child: ClipOval(
          child: photoBytes != null
              ? Image.memory(
                  photoBytes!,
                  fit: BoxFit.cover,
                )
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