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

        const SizedBox(width: 24),

        const PriorityFilter(),
      ],
    );
  }
}