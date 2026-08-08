import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/gallery_images_row.dart';


import 'package:flutter/material.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key, required this.order, required this.onEdit});

  final OrderDetails order;

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final isPublished = order.isPublished ?? false;

    return Card(
      elevation: 0,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// اسم الحالة
            Text(
              order.caseName ?? "بدون اسم",

              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// الصور
            GalleryImagesRow(
              editable: false,

              beforeImageUrl: order.beforeImagePath,

              afterImageUrl: order.afterImagePath,
            ),

            const SizedBox(height: 20),

           
            const SizedBox(height: 12),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(.06),

                borderRadius: BorderRadius.circular(14),
              ),

              child: Text(
                isPublished
                    ? "هذه الطلبية مضافة إلى معرض الأعمال، يمكنك تغيير معلوماتها أو جعلها غير متاحة."
                    : "هذه الطلبية محفوظة كمسودة في معرض الأعمال، يمكنك تعديل معلوماتها أو نشرها لاحقاً.",

                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: AlignmentDirectional.centerEnd,

              child: FilledButton.icon(
                onPressed: onEdit,

                icon: const Icon(Icons.edit_outlined),

                label: const Text("تعديل"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
