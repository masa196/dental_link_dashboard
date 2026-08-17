import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/tabs/dashboard_tab_model.dart';
import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/tabs/dashboard_tabs.dart';
import 'priority_filter.dart';

class OrdersFiltersBar extends StatelessWidget {
  const OrdersFiltersBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<DashboardTabModel> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const priorityWidth = 150.0;
        const spacing = 24.0;

        /*
         * الحد الأدنى للمساحة المطلوبة حتى يبقى
         * الـ Tabs والـ PriorityFilter بدون ضغط.
         */
        const minimumTabsWidth = 300.0;

        final minimumRequiredWidth =
            minimumTabsWidth +
            spacing +
            priorityWidth;

        final shouldScroll =
            constraints.maxWidth < minimumRequiredWidth;

        if (shouldScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: minimumRequiredWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: minimumTabsWidth,
                    child: DashboardTabs(
                      tabs: tabs,
                      selectedIndex: selectedIndex,
                      onTap: onTabChanged,
                    ),
                  ),

                  const SizedBox(width: spacing),

                  const SizedBox(
                    width: priorityWidth,
                    child: PriorityFilter(),
                  ),
                ],
              ),
            ),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: DashboardTabs(
                tabs: tabs,
                selectedIndex: selectedIndex,
                onTap: onTabChanged,
              ),
            ),

            const SizedBox(width: spacing),

            const SizedBox(
              width: priorityWidth,
              child: PriorityFilter(),
            ),
          ],
        );
      },
    );
  }
}