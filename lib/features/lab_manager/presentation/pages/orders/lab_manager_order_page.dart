import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/orders/orders_view.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabManagerOrdersPage extends StatelessWidget {
  const LabManagerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ShowOrdersBloc>()
        ..add(const ShowOrdersRequested(status: 'new')),
      child: const OrdersView(mode: OrdersMode.labManager),
    );
  }
}