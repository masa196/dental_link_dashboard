import 'package:flutter/material.dart';
import '../models/dashboard_tab_model.dart';

class DashboardTabItem extends StatelessWidget {
  final DashboardTabModel tab;
  final VoidCallback onTap;
  final bool isActive;

 const DashboardTabItem({
  super.key,
  required this.tab,
  required this.isActive,
  required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    final active = isActive;
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  tab.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: active ? scheme.primary : scheme.onSurface,
                  ),
                ),

                const SizedBox(width: 6),

              ],
            ),

            const SizedBox(height: 6),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: active ? 60 : 0,
              color: scheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
