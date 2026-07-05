import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dashboard_header/dashboard_header.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/orders_list.dart';

class OrdersView extends StatelessWidget {
  final OrdersMode mode;

  const OrdersView({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DashboardHeader(),
        Expanded(
          child: OrdersList(mode: mode),
        ),
      ],
    );
  }
}