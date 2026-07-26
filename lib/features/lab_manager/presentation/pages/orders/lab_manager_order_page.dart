import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/get_order_delivery_time/get_order_delivery_time_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/update_order_delivery_time/update_order_delivery_time_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/orders/lab_manager_dashboard_view.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/create_delivery_assignment/create_delivery_assignment_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabManagerOrdersPage extends StatelessWidget {
  const LabManagerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ReceptionistDashboardCubit>()),

        BlocProvider(
          create: (_) =>
              locator<ShowOrdersBloc>()
                ..add(const ShowOrdersRequested(status: 'new')),
        ),

        BlocProvider(create: (_) => locator<PrintQrBloc>()),

        BlocProvider(create: (_) => locator<UpdateOrderStatusBloc>()),

        BlocProvider(
          create: (_) =>
              locator<ShowDeliveryEmployeesBloc>()
                ..add(const LoadDeliveryEmployees()),
        ),

        BlocProvider(create: (_) => locator<CreateDeliveryAssignmentBloc>()),

        BlocProvider(create: (_) => locator<GetOrderDeliveryTimeBloc>()),

        BlocProvider(create: (_) => locator<UpdateOrderDeliveryTimeBloc>()),
      ],
      child: const LabManagerDashboardView(mode: OrdersMode.labManager),
    );
  }
}
