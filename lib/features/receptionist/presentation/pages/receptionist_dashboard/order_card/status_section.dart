import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/outline_pill.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/orders_model/orders_model.dart';

class StatusSection extends StatelessWidget {
  final OrderModel order;
  final bool showAttachment;
  final VoidCallback? onAttachmentsPressed;

  const StatusSection({
    super.key,
    required this.order,
    this.showAttachment = true,
    this.onAttachmentsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 120,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: OutlinePill(
              label: order.orderType ?? "No Type",
              background: AppLightColors.background,
              borderColor: AppLightColors.accent,
              textColor: AppLightColors.primary,
            ),
          ),
        ),

        const SizedBox(height: 12),

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 160,
          ),
          child: InkWell(
            onTap: showAttachment
                ? onAttachmentsPressed
                : null,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: scheme.outline,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.attach_file,
                    size: 14,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      "ملحقات الطلبية",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}