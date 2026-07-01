import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_event.dart';
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
        BlocProvider(
          create: (_) => locator<ReceptionistDashboardCubit>(),
        ),

        BlocProvider(
          create: (_) => locator<ShowOrdersBloc>()
            ..add(
              const ShowOrdersRequested(
                status: 'new',
              ),
            ),
        ),
      ],
      child: const ReceptionistDashboardView(),
    );
  }
}