import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/create_delivery_assignment/create_delivery_assignment_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/receptionist_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionistDashboardPage extends StatelessWidget {
  const ReceptionistDashboardPage({super.key});

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

      

       
      ],
      child: const ReceptionistDashboardView(mode: OrdersMode.receptionist),
    );
  }
}
