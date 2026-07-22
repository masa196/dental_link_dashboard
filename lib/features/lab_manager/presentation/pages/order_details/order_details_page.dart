import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/order_details_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ShowOrderDetailsBloc>()
        ..add(
          ShowOrderDetailsRequested(
            orderId,
          ),
        ),
      child: const OrderDetailsBody(),
    );
  }
}