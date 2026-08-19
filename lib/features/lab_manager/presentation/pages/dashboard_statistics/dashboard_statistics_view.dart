import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/dashboard_statistics/dashboard_statistics_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/dashboard_statistics/dashboard_statistics_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/dashboard_statistics/widgets/dashboard_statistics_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class DashboardStatisticsView extends StatelessWidget {
  const DashboardStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        DashboardStatisticsBloc,
        DashboardStatisticsState>(
      builder: (context, state) {
        if (state is DashboardStatisticsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is DashboardStatisticsFailure) {
          return _StatisticsError(
            message: state.failure.message,
          );
        }

        if (state is DashboardStatisticsSuccess) {
          final data = state.statistics.data;

          if (data == null) {
            return const _StatisticsEmpty();
          }

          return DashboardStatisticsContent(
            data: data,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _StatisticsEmpty extends StatelessWidget {
  const _StatisticsEmpty();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'لا توجد بيانات لعرض الإحصائيات',
      ),
    );
  }
}

class _StatisticsError extends StatelessWidget {
  const _StatisticsError({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 42,
              color: Color(0xFFE05A66),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}