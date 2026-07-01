import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/departments_with_employee/departments_with_employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';

class EditEmployeeDepartmentsSection extends StatelessWidget {
  const EditEmployeeDepartmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentsWithEmployeeBloc, DepartmentsWithEmployeeState>(
      builder: (context, deptState) {
        if (deptState.status == DepartmentsWithEmployeeStatus.loading && deptState.departments.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF008080)),
          );
        }

        return BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
          builder: (context, formState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الأقسام المختصة للموظف (اختر قسماً واحداً أو أكثر):',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: deptState.departments.map((department) {
                      if (department.id == null) return const SizedBox.shrink();
                      
                      final int deptId = department.id is int ? department.id as int : (int.tryParse(department.id.toString()) ?? 0);
                      final bool isChecked = formState.departmentIds.contains(deptId);

                      return FilterChip(
                        label: Text(department.name ?? ''),
                        selected: isChecked,
                        selectedColor: const Color(0xFF008080),
                        checkmarkColor: const Color(0xFF008080),
                        labelStyle: TextStyle(
                          color: isChecked ? const Color(0xFF008080) : Colors.black87,
                          fontWeight: isChecked ? FontWeight.bold : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isChecked ? const Color(0xFF008080) : Colors.grey.shade400,
                          ),
                        ),
                        onSelected: (_) {
                          context.read<UpdateEmployeeFormCubit>().clearDepartmentError();
                          context.read<UpdateEmployeeFormCubit>().toggleDepartment(deptId);
                        },
                      );
                    }).toList(),
                  ),
                ),
                if (formState.departmentError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 4),
                    child: Text(
                      formState.departmentError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}