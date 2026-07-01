import 'package:flutter/material.dart';
import '../models/dashboard_tab_model.dart';
import 'dashboard_tab_item.dart';

class DashboardTabs extends StatelessWidget {
  final List<DashboardTabModel> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const DashboardTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffE5E7EB), width: 1),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          return DashboardTabItem(
            tab: tabs[index],
            isActive: selectedIndex == index,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}