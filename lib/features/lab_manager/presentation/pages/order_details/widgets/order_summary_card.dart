// ignore_for_file: deprecated_member_use

import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final teeth = order.teeth ?? [];

    return Card(
      elevation: 0,
      color: scheme.surface,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.priority_high_rounded,
                    title: "الأولوية",
                    value: _priorityLabel(order.priority),
                    color: _priorityColor(order.priority, scheme),
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.category_outlined,
                    title: "نوع الطلب",
                    value: order.orderType ?? "-",
                    color: scheme.primary,
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.timeline,
                    title: "الحالة",
                    value: _statusLabel(order.status),
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(color: scheme.outline),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.tag, size: 20, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  "الأسنان المطلوبة (${teeth.length})",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),

            if (teeth.isEmpty)
              Text(
                "لا يوجد أسنان محددة",
                style: TextStyle(color: scheme.onSurfaceVariant),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: teeth.map((tooth) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.primary.withOpacity(.08),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      tooth.toothNumber?.toString() ?? "-",
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  String _priorityLabel(String? priority) {
    switch (priority) {
      case "urgent":
        return "عاجلة";

      default:
        return "عادية";
    }
  }

  Color _priorityColor(String? priority, ColorScheme scheme) {
    switch (priority) {
      case "urgent":
        return Colors.red;

      default:
        return scheme.primary;
    }
  }

  String _statusLabel(String? status) {
    switch (status) {
      case "new":
        return "جديدة";

      case "pending":
        return "قيد الانتظار";

      case "in_progress":
        return "قيد التنفيذ";

      case "resend_wrong_impression":
        return "إعادة الطبعة";

      case "try_on":
        return "تجربة";

      case "completed":
        return "مكتملة";

      default:
        return status ?? "-";
    }
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withOpacity(.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 10),

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 10),

              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
