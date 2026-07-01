import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/orders_model.dart';
import 'patient_section.dart';
import 'specs_section.dart';
import 'status_section.dart';
import 'date_action_section.dart';
import 'workflow/workflow_section.dart';
import 'card_section_divider.dart';

class DesktopOrderCard extends StatelessWidget {
  final OrderModel order;
  final String buttonTitle;

  const DesktopOrderCard({
    super.key,
    required this.order,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ReceptionistDashboardCubit>();

    final showWorkflow = cubit.shouldUseWorkflow(cubit.state.selectedTab);

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? const Color(0xffF1F5F9)
              : scheme.outlineVariant.withOpacity(0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: PatientSection(order: order)),

          const CardSectionDivider(),
          Expanded(flex: 5, child: _buildMiddleSection(showWorkflow)),

          const CardSectionDivider(),

          Expanded(
            flex: 2,
            child: DateActionSection(order: order, buttonTitle: buttonTitle),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection(bool showWorkflow) {
    if (showWorkflow) {
      return WorkflowSection(steps: order.workflowSteps);
    }

    return Row(
      children: [
        Expanded(child: SpecsSection(order: order)),
        const SizedBox(width: 40),
        SizedBox(width: 120, child: StatusSection(order: order)),
      ],
    );
  }
}
