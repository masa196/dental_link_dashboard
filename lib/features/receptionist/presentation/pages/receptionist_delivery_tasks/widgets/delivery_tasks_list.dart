import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_tasks/show_delivery_tasks_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/widgets/delivery_task_card.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/widgets/delivery_task_empty_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/widgets/delivery_task_error_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_delivery_tasks/widgets/delivery_task_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryTasksList extends StatelessWidget {
  const DeliveryTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowDeliveryTasksBloc, ShowDeliveryTasksState>(
      builder: (context, state) {
        /// Loading
        if (state.isLoading) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (_, __) => const DeliveryTaskSkeleton(),
          );
        }

        if (state.failure != null && state.tasks.isEmpty) {
          return DeliveryTasksErrorState(
            message: state.failure!.message,
            onRetry: () {
              context.read<ShowDeliveryTasksBloc>().add(
                const ShowDeliveryTasksRequested(),
              );
            },
          );
        }

        if (state.tasks.isEmpty) {
          return const DeliveryTasksEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ShowDeliveryTasksBloc>().add(
              const ShowDeliveryTasksRefresh(),
            );
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: state.tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, index) {
              final task = state.tasks[index];

              return DeliveryTaskCard(
                task: task,

                onLocationTap: () {
                  /// سنربط الخريطة لاحقًا
                },
              );
            },
          ),
        );
      },
    );
  }
}
