import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';

class TimeTrackingCard extends StatelessWidget {
  const TimeTrackingCard({
    super.key,
    required this.order,
  });

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

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

            Text(
              "تتبع الوقت",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            _TimeRow(
              title: "الوقت المنقضي",
              value: order.elapsedTime?.human ?? "-",
              color: Colors.blue,
              icon: Icons.schedule,
            ),

            const SizedBox(height: 18),

            _TimeRow(
              title: "الوقت المتبقي",
              value: order.remainingTime?.human ?? "-",
              color: order.remainingTime?.isOverdue == true
                  ? Colors.red
                  : Colors.green,
              icon: Icons.timer_outlined,
            ),

            const SizedBox(height: 18),

            _TimeRow(
              title: "المدة المتوقعة",
              value:
                  "${order.estimatedTotalHours ?? 0} ساعة",
              color: scheme.primary,
              icon: Icons.av_timer,
            ),

            const Divider(height: 32),

            _DateRow(
              title: "تاريخ البدء",
              value: order.startDate,
            ),

            const SizedBox(height: 14),

            _DateRow(
              title: "تاريخ التسليم",
              value: order.endDate,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          icon,
          color: color,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(title),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(.08),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.title,
    required this.value,
  });

  final String title;
  final DateTime? value;

  @override
  Widget build(BuildContext context) {

    String text = "-";

    if (value != null) {
      text =
          "${value!.day}/${value!.month}/${value!.year}";
    }

    return Row(
      children: [

        Expanded(
          child: Text(title),
        ),

        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}