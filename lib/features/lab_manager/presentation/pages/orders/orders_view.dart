/*import 'package:dental_link_dashboard/core/navigation/lab_manager_layout.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/orders_list.dart';

class OrdersView extends StatelessWidget {
  final OrdersMode mode;

  const OrdersView({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeader(
                title: "ادارة الطلبات ",
                showMenuButton: !Responsive.isDesktop(context),
                onMenuPressed: LayoutScope.of(context).openDrawer,
                onSearch: (_) {},
                onNotificationTap: () {},
              ),
        Expanded(
          child: OrdersList(mode: mode),
        ),
      ],
    );
  }
}*/