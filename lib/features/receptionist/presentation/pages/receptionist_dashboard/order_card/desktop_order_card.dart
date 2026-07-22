// ignore_for_file: deprecated_member_use

import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dialogs/order_attachments_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/orders_model/orders_model.dart';
import 'patient_section.dart';
import 'specs_section.dart';
import 'status_section.dart';
import 'date_action_section.dart';

import 'workflow/workflow_section.dart';
import 'card_section_divider.dart';

class DesktopOrderCard extends StatelessWidget {
  final OrderModel order;
  final Widget? actionWidget;
  final bool showWorkflow;
  final String buttonTitle;
  final bool showDetailsButton;
  final VoidCallback? onDetailsPressed;

  const DesktopOrderCard({
    super.key,
    required this.order,
    this.actionWidget,
    required this.showWorkflow,
    required this.buttonTitle,
    this.showDetailsButton = false,
    this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
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
          Expanded(flex: 5, child: _buildMiddleSection(context, showWorkflow)),

          const CardSectionDivider(),

          Expanded(
            flex: 2,
            child: DateActionSection(
              order: order,
              buttonTitle: buttonTitle,
              actionWidget: actionWidget,
              showDetailsButton: showDetailsButton,
              onDetailsPressed: onDetailsPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection(BuildContext context, bool showWorkflow) {
    if (showWorkflow) {
      return Center(child: WorkflowSection(steps: order.workflowSteps));
    }

    return Row(
      children: [
        Expanded(child: SpecsSection(order: order)),
        const SizedBox(width: 40),
        SizedBox(
          width: 120,
          child: StatusSection(
            order: order,
            onAttachmentsPressed: () {
              showDialog(
                context: context,
                builder: (_) =>
                    OrderAttachmentsDialog(files: order.files ?? []),
              );
            },
          ),
        ),
      ],
    );
  }
}
