import 'package:flutter/material.dart';

class DeliveryTasksEmptyState extends StatelessWidget {
  const DeliveryTasksEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 60,
            color: scheme.primary.withValues(alpha: 0.6),
          ),

          const SizedBox(height: 12),

          Text(
            "لا يوجد مهام توصيل ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),

          const SizedBox(height: 6),

        
        ],
      ),
    );
  }
}