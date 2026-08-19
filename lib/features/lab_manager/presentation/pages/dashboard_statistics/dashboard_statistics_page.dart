import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/dashboard_statistics/dashboard_statistics_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/dashboard_statistics/dashboard_statistics_event.dart';

import 'dashboard_statistics_view.dart';

class DashboardStatisticsPage extends StatelessWidget {
  const DashboardStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DashboardStatisticsBloc>()
        ..add(
          const GetDashboardStatisticsEvent(),
        ),
      child: const DashboardStatisticsView(),
    );
  }
}