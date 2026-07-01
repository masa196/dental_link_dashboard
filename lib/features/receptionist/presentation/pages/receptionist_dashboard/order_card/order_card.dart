import 'package:flutter/material.dart';

import '../../../../data/models/orders_model.dart';
import 'desktop_order_card.dart';
import 'mobile_order_card.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final String buttonTitle;
  final bool showWorkflow;

  const OrderCard({
    super.key,
    required this.order,
    required this.buttonTitle,
    this.showWorkflow = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return isDesktop
        ? DesktopOrderCard(order: order, buttonTitle: buttonTitle)
        : MobileOrderCard(
            order: order,
            buttonTitle: buttonTitle,
            showWorkflow: showWorkflow,
          );
  }
}
