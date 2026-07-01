import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/orders_model.dart';

class DateActionSection extends StatelessWidget {
  final OrderModel order;
  final String buttonTitle;

  const DateActionSection({
    super.key,
    required this.order,
    required this.buttonTitle,
  });

  String _format(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = order.remainingDays ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _DateTile(label: 'تاريخ الاستلام', value: _format(order.receivedAt)),

        const SizedBox(height: 8),

        _DateTile(label: 'تاريخ التسليم', value: _format(order.deliveredAt)),

        const SizedBox(height: 10),

        Text(
          "$remaining يوم",
          style: TextStyle(
            color: remaining <= 1
                ? const Color(0xffE6354A)
                : Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          width: 180,
          height: 34,
          child: FilledButton(
            onPressed: () {},
            child: Text(
              buttonTitle,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final String value;

  const _DateTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
