import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/system_logs/system_logs_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/system_logs/system_logs_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/system_logs/system_logs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemLogsPage extends StatelessWidget {
  const SystemLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => locator<SystemLogsBloc>()
        ..add(const GetSystemLogsEvent()),
      child: const SystemLogsView(),
    );
  }
}