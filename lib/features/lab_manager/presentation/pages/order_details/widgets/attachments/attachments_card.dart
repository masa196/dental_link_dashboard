import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'attachment_button.dart';
import 'image_gallery_dialog.dart';

class AttachmentsCard extends StatelessWidget {
  const AttachmentsCard({super.key, required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final images =
        order.files?.where((file) => file.fileType == "image").toList() ?? [];

    final otherFiles =
        order.files?.where((file) => file.fileType != "image").toList() ?? [];

    return Card(
      elevation: 0,

      color: Theme.of(context).colorScheme.surface,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),

        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "ملحقات الحالة",

              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // الصور المرسلة من الطبيب
            if (images.isNotEmpty)
              AttachmentButton(
                title: "الصور المرسلة من الطبيب",

                icon: Icons.image_outlined,

                count: images.length,

                onTap: () {
                  showDialog(
                    context: context,

                    builder: (_) {
                      return ImageGalleryDialog(
                        images: images
                            .map((file) => file.filePath ?? "")
                            .toList(),
                      );
                    },
                  );
                },
              ),

            if (images.isNotEmpty && otherFiles.isNotEmpty)
              const SizedBox(height: 14),

            const SizedBox(height: 14),
            AttachmentButton(
              title: "ملف الطبعة المرسل من الطبيب",

              icon: Icons.attach_file_outlined,

              count: otherFiles.length,

              onTap: () async {
                for (final file in otherFiles) {
                  if (file.filePath != null) {
                    await _openFile(file.filePath!);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openFile(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
