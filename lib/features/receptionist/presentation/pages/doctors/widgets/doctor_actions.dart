import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:flutter/material.dart';

class DoctorActions extends StatelessWidget {
  const DoctorActions({super.key, required this.onDetails});

  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.lg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton.icon(
            onPressed: onDetails,

            icon: const Icon(Icons.visibility_outlined, size: 18),

            label: const Text("عرض التفاصيل"),

            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
