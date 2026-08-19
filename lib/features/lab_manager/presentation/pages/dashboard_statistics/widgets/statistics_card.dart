import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/dashboard_statistics/widgets/statistics_colors.dart';
import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StatisticsColors.surface(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: StatisticsColors.outline(context),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.15
                  : 0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            child: Row(
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الأيقونة تبقى في الطرف المقابل للعنوان
                if (icon != null)
                  Icon(
                    icon,
                    size: 20,
                    color: StatisticsColors.hint(context),
                  ),

                const SizedBox(width: 12),

                // منطقة العنوان تأخذ كامل المساحة المتبقية
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: StatisticsColors.primary(context),
                        ),
                      ),

                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: StatisticsColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: StatisticsColors.divider(context),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}