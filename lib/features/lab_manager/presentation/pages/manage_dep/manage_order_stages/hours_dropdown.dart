import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class HoursDropdown extends StatelessWidget {
  const HoursDropdown({
    super.key,
    required this.hours,
    required this.enabled,
    required this.onChanged,
  });

  final int hours;

  final bool enabled;

  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;

    if (!enabled) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
          border: Border.all(
            color: scheme.outlineVariant,
          ),
        ),
        child: Text(
          _hoursText(
            isArabic,
            hours,
          ),
          style: const TextStyle(
            fontSize: AppTypography.fs10,
          ),
        ),
      );
    }

    return DropdownButtonFormField<int>(
      value: hours,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.md,
          ),
        ),
      ),
      items: List.generate(
        24,
        (index) {
          final hour = index + 1;

          return DropdownMenuItem<int>(
            value: hour,
            child: Text(
              _hoursText(
                isArabic,
                hour,
              ),
            ),
          );
        },
      ),
      onChanged: (value) {
        if (value == null) return;

        onChanged(value);
      },
    );
  }

  String _hoursText(
    bool isArabic,
    int value,
  ) {
    if (isArabic) {
      return '$value ساعة';
    }

    return '$value hour${value == 1 ? '' : 's'}';
  }
}