import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/order_card/workflow/workflow_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/orders_model/orders_model.dart';
import 'date_action_section.dart';
import 'patient_section.dart';
import 'specs_section.dart';
import 'status_section.dart';

class MobileOrderCard extends StatelessWidget {
  final OrderModel order;
  final Widget? actionWidget;

  const MobileOrderCard({super.key, required this.order, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final cubit = context.watch<ReceptionistDashboardCubit>();

    final buttonTitle = cubit.getButtonTitle(cubit.state.selectedTab);

    final showWorkflow = cubit.shouldUseWorkflow(cubit.state.selectedTab);

    return Card(
      elevation: 0,
      color: scheme.surface,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PatientSection(order: order),

            const SizedBox(height: 16),

            if (showWorkflow)
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: WorkflowSection(steps: order.workflowSteps),
                ),
              )
            else ...[
              SpecsSection(order: order),

              const SizedBox(height: 16),

              SizedBox(width: 120, child: StatusSection(order: order)),
            ],

            const SizedBox(height: 16),

            DateActionSection(
              order: order,
              buttonTitle: buttonTitle,
              actionWidget: actionWidget,
            ),
          ],
        ),
      ),
    );
  }
}
