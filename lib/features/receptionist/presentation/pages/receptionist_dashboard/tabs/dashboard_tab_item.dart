import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/tabs/dashboard_tab_model.dart';
import 'package:flutter/material.dart';


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
    final scheme = Theme.of(context).colorScheme;
    final active = isActive;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 140),
              child: Text(
                tab.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: active ? scheme.primary : scheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 6),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,

              // 🔥 بدل width ثابت -> مرن أكثر
              width: active ? 40 : 0,

              color: scheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
