

import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/timeline/models/order_timeline_step.dart';
import 'package:flutter/material.dart';
import 'order_timeline_item.dart';

class OrderTimelineCard extends StatelessWidget {
  const OrderTimelineCard({
    super.key,
    required this.steps,
  });

  final List<OrderTimelineStep> steps;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: scheme.outline,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "سير العمل",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 28),

            ...List.generate(
              steps.length,
              (index) => OrderTimelineItem(
                step: steps[index],
                isLast: index == steps.length - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}