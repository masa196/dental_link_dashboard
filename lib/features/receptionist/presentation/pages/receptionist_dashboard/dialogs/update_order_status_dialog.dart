import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:flutter/material.dart';

class UpdateOrderStatusDialog extends StatefulWidget {
  const UpdateOrderStatusDialog({super.key, required this.onSubmit});

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
    return AlertDialog(
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
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        FilledButton(
          onPressed: () {
            widget.onSubmit(
              _selected,
              _notesController.text.trim().isEmpty
                  ? null
                  : _notesController.text.trim(),
            );

            Navigator.pop(context);
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}
