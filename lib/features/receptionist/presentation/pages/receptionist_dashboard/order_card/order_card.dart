import 'package:flutter/material.dart';

import '../../../../data/models/orders_model/orders_model.dart';
import 'desktop_order_card.dart';
import 'mobile_order_card.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final Widget? actionWidget;
  final bool showWorkflow;

  const OrderCard({
    super.key,
    required this.order,
    this.actionWidget,
    this.showWorkflow = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return isDesktop
        ? DesktopOrderCard(order: order, actionWidget: actionWidget)
        : MobileOrderCard(order: order, actionWidget: actionWidget);
  }
}
