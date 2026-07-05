import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/tabs/dashboard_tab_model.dart';
import 'package:flutter/material.dart';
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
    final textDirection = Directionality.of(context);

    return Directionality(
      textDirection: textDirection,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffE5E7EB), width: 1),
          ),
        ),
        alignment: textDirection == TextDirection.rtl
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Align(
            alignment: textDirection == TextDirection.rtl
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: textDirection,
              children: List.generate(
                tabs.length,
                (index) => DashboardTabItem(
                  tab: tabs[index],
                  isActive: selectedIndex == index,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
