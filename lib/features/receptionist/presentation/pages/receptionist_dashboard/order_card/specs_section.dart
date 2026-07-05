import 'package:flutter/material.dart';

import '../../../../data/models/orders_model/orders_model.dart';
import 'spec_divider.dart';

class SpecsSection extends StatelessWidget {
  final OrderModel order;

  const SpecsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? const Color(0xffF5F7FA)
            : Color.alphaBlend(
                Colors.white.withValues(alpha: 0.03),
                scheme.surface,
              ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? Colors.transparent
              : scheme.outline,
        ),
      ),
      child: Row(
        children: [
          const SpecDivider(),

          Expanded(
            child: _SpecItem(
              label: 'نوع الحالة ',
              value: order.caseType ?? "No_Type",
            ),
          ),

          const SpecDivider(),

          Expanded(
            child: _SpecItem(
              label: 'المادة',
              value: order.materialType ?? "No_Material",
            ),
          ),

          const SpecDivider(),

          Expanded(
            child: _SpecItem(
              label: 'اللون',
              value: order.toothShadeName ?? "No_Color",
            ),
          ),

          const SpecDivider(),

          Expanded(
            child: _SpecItem(
              label: 'السعر',
              value: order.price ?? "-",
              accent: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;

  const _SpecItem({
    required this.label,
    required this.value,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: theme.brightness == Brightness.light
                ? Colors.grey.shade500
                : Colors.grey.shade400,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: accent ? 15 : 14,
            fontWeight: FontWeight.w700,
            color: accent ? scheme.primary : scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
