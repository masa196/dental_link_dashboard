import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_bloc.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateOrderStatusDialog extends StatefulWidget {
  final int orderId;

  const UpdateOrderStatusDialog({
    super.key,
    required this.orderId,
    required this.onSubmit,
  });

  final void Function(UpdateOrderStatusOption status, String? notes) onSubmit;

  @override
  State<UpdateOrderStatusDialog> createState() =>
      _UpdateOrderStatusDialogState();
}

class _UpdateOrderStatusDialogState extends State<UpdateOrderStatusDialog> {
  final _notesController = TextEditingController();

  UpdateOrderStatusOption _selected = UpdateOrderStatusOption.needsTest;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateOrderStatusBloc, UpdateOrderStatusState>(
      listener: (context, state) {
        if (state.status == UpdateOrderStatusStatus.success) {
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        title: const Text("Update Order Status"),

        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SegmentedButton<UpdateOrderStatusOption>(
                segments: [
                  ButtonSegment(
                    value: UpdateOrderStatusOption.needsTest,
                    label: Text(UpdateOrderStatusOption.needsTest.title),
                  ),
                  ButtonSegment(
                    value: UpdateOrderStatusOption.needsRedo,
                    label: Text(UpdateOrderStatusOption.needsRedo.title),
                  ),
                ],
                selected: {_selected},
                onSelectionChanged: (value) {
                  setState(() {
                    _selected = value.first;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _notesController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Notes (Optional)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Cancel"),
          ),

          BlocBuilder<UpdateOrderStatusBloc, UpdateOrderStatusState>(
            builder: (context, state) {
              final isLoading = state.status == UpdateOrderStatusStatus.loading;

              return FilledButton(
                onPressed: isLoading
                    ? null
                    : () {
                        widget.onSubmit(
                          _selected,
                          _notesController.text.trim().isEmpty
                              ? null
                              : _notesController.text.trim(),
                        );
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Update"),
              );
            },
          ),
        ],
      ),
    );
  }
}
