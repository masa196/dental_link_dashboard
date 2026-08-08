import 'package:flutter/material.dart';

class DoctorsError extends StatelessWidget {
  const DoctorsError({super.key, required this.failure});

  final Object failure;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(32),

      decoration: BoxDecoration(
        color: scheme.onSurfaceVariant,

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(Icons.error_outline, size: 48, color: scheme.error),

          const SizedBox(height: 16),

          Text(
            "حدث خطأ أثناء تحميل الأطباء",

            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
