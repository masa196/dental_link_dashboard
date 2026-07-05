import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dialogs/show_delivery_employee_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDeliveryTaskButton extends StatelessWidget {
  final ValueChanged<int> onEmployeeSelected;

  const CreateDeliveryTaskButton({
    super.key,
    required this.onEmployeeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<
        ShowDeliveryEmployeesBloc,
        ShowDeliveryEmployeesState>(
      listener: (context, state) async {
        if (state.status ==
            ShowDeliveryEmployeesStatus.loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.status ==
            ShowDeliveryEmployeesStatus.failure) {
          Navigator.of(context, rootNavigator: true).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failure?.message ?? "حدث خطأ",
              ),
            ),
          );
        }

        if (state.status ==
            ShowDeliveryEmployeesStatus.success) {
          Navigator.of(context, rootNavigator: true).pop();

          final employees =
              state.response?.data?.data ?? [];

          final employeeId =
              await showDeliveryEmployeeDialog(
            context,
            employees,
          );

          if (employeeId != null) {
            onEmployeeSelected(employeeId);
          }
        }
      },

      child: ElevatedButton(
        onPressed: () {
          context
              .read<ShowDeliveryEmployeesBloc>()
              .add(
                const LoadDeliveryEmployees(),
              );
        },

        child: const Text(
          "إنشاء مهمة توصيل",
        ),
      ),
    );
  }
}