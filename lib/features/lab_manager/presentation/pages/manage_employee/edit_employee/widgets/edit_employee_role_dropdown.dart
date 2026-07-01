import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_employee/roles/roles_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditEmployeeRoleDropdown extends StatelessWidget {
  const EditEmployeeRoleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<RolesBloc, RolesBlocState>(
      builder: (context, rolesState) {
      
        if (rolesState.status == RolesStatus.loading &&
            rolesState.roles.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

      
        if (rolesState.status == RolesStatus.failure &&
            rolesState.roles.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'خطأ في تحميل الأدوار من السيرفر',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

       
        final List<DropdownMenuItem<int>> dropdownItems = rolesState.roles.map((
          role,
        ) {
          return DropdownMenuItem<int>(
            value: role.id ?? 0, 
            child: Text(role.name ?? ''), 
          );
        }).toList();

      
        return BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
          builder: (context, formState) {
         
            final bool hasValueInItems = dropdownItems.any(
              (item) => item.value == formState.roleId,
            );
            final int? selectedValue = hasValueInItems
                ? formState.roleId
                : null;

            return DropdownButtonFormField<int>(
              initialValue: selectedValue,
              decoration: InputDecoration(
                labelText: 'الدور / الصلاحية',
                errorText: formState.roleError,
                border: const OutlineInputBorder(),
              ),
              items:
                  dropdownItems, 
              onChanged: (int? newRoleId) {
                if (newRoleId != null) {
                  context.read<UpdateEmployeeFormCubit>().setRole(newRoleId);
                }
              },
            );
          },
        );
      },
    );
  }
}
