import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/orders_model/orders_model.dart';

class DateActionSection extends StatelessWidget {
  final OrderModel order;
  final String buttonTitle;
  final Widget? actionWidget;
  final VoidCallback? onDetailsPressed;
  final bool showDetailsButton;

  const DateActionSection({
    super.key,
    required this.order,
    required this.buttonTitle,
    this.actionWidget,
    this.onDetailsPressed,
    this.showDetailsButton = false,
  });

  String _format(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = order.remainingDays ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 200;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _DateTile(
              label: 'تاريخ الاستلام',
              value: _format(order.receivedAt),
              isCompact: isCompact,
            ),

            const SizedBox(height: 8),

            _DateTile(
              label: 'تاريخ التسليم',
              value: _format(order.deliveredAt),
              isCompact: isCompact,
            ),

            const SizedBox(height: 10),

            Text(
              "$remaining يوم",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: remaining <= 1
                    ? const Color(0xffE6354A)
                    : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 14),

           Row(
  children: [

    if (showDetailsButton)
      SizedBox(
        width: 38,
        height: 38,
        child: IconButton(
          tooltip: "تفاصيل الحالة",
          icon: const Icon(Icons.visibility_outlined),
          onPressed: onDetailsPressed,
        ),
      ),

    if (showDetailsButton)
      const SizedBox(width: 8),

    Expanded(
      child: SizedBox(
        height: 36,
        child: actionWidget ??
            FilledButton(
              onPressed: null,
              child: Text(
                buttonTitle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
      ),
    ),
  ],
)
          ],
        );
      },
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isCompact;

  const _DateTile({
    required this.label,
    required this.value,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return isCompact
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          );
  }
}
