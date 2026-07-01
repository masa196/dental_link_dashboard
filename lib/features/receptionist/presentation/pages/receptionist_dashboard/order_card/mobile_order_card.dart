import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/order_card/workflow/workflow_section.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/orders_model.dart';
import 'date_action_section.dart';
import 'patient_section.dart';
import 'specs_section.dart';
import 'status_section.dart';

class MobileOrderCard extends StatelessWidget {
  final OrderModel order;
  final String buttonTitle;
  final bool showWorkflow;

  const MobileOrderCard({
    super.key,
    required this.order,
    required this.buttonTitle,
    this.showWorkflow = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
              WorkflowSection(steps: order.workflowSteps)
            else ...[
              SpecsSection(order: order),

              const SizedBox(height: 16),

              SizedBox(width: 120, child: StatusSection(order: order)),
            ],

            const SizedBox(height: 16),

            DateActionSection(order: order, buttonTitle: buttonTitle),
          ],
        ),
      ),
    );
  }
}
