import 'package:flutter/material.dart';

class DeliveryTaskSkeleton extends StatelessWidget {
  const DeliveryTaskSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget box({double h = 14, double w = double.infinity}) {
      return Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            children: [
              box(w: 120, h: 22),
              const Spacer(),
              box(w: 80, h: 18),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(child: box(h: 12)),
              const SizedBox(width: 12),
              Expanded(child: box(h: 12)),
              const SizedBox(width: 12),
              Expanded(child: box(h: 12)),
            ],
          ),

          const SizedBox(height: 16),

          box(h: 12),

          const SizedBox(height: 10),

          box(h: 12, w: 200),
        ],
      ),
    );
  }
}