import 'package:flutter/material.dart';

import '../../../../data/models/orders_model.dart';

class StatusSection extends StatelessWidget {
  final OrderModel order;

  const StatusSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final isUrgent = order.priority == "urgent";

    final color = isUrgent ? const Color(0xFFEF4444) : const Color(0xFF3B82F6);

    final background = isUrgent
        ? const Color(0xFFFEE2E2)
        : const Color(0xFFE0F2FE);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color),
          ),
          child: Text(
            isUrgent ? "مستعجل" : "عادي",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: scheme.outline),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_file, size: 14),
              SizedBox(width: 6),
              Text("ملحقات الطلبية", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
