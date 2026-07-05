import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';
import 'package:flutter/material.dart';

class DeliveryEmployeeDialog extends StatefulWidget {
  final List<DeliveryEmplyee> employees;

  const DeliveryEmployeeDialog({
    super.key,
    required this.employees,
  });

  @override
  State<DeliveryEmployeeDialog> createState() =>
      _DeliveryEmployeeDialogState();
}

class _DeliveryEmployeeDialogState
    extends State<DeliveryEmployeeDialog> {

  int? selectedEmployeeId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر موظف التوصيل"),

      content: SizedBox(
        width: 420,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.employees.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {

            final employee = widget.employees[index];

            return RadioListTile<int>(
              value: employee.id!,
              groupValue: selectedEmployeeId,

              onChanged: (value) {
                setState(() {
                  selectedEmployeeId = value;
                });
              },

              title: Text(employee.name ?? ""),

              subtitle: Text(
                employee.phone ?? "",
              ),
            );
          },
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("إلغاء"),
        ),

        ElevatedButton(
          onPressed: selectedEmployeeId == null
              ? null
              : () {
                  Navigator.pop(
                    context,
                    selectedEmployeeId,
                  );
                },
          child: const Text("متابعة"),
        ),
      ],
    );
  }
}