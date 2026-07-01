import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';
import 'edit_employee_role_dropdown.dart';
import 'edit_employee_departments_section.dart';

class EditEmployeeTextFields extends StatefulWidget {
  const EditEmployeeTextFields({super.key});

  @override
  State<EditEmployeeTextFields> createState() => _EditEmployeeTextFieldsState();
}

class _EditEmployeeTextFieldsState extends State<EditEmployeeTextFields> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _birthdateCtrl;
  late final TextEditingController _joinedAtCtrl;

  @override
  void initState() {
    super.initState();
    final initialState = context.read<UpdateEmployeeFormCubit>().state;
    _nameCtrl = TextEditingController(text: initialState.name);
    _birthdateCtrl = TextEditingController(text: initialState.birthdate);
    _joinedAtCtrl = TextEditingController(text: initialState.joinedAt);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _birthdateCtrl.dispose();
    _joinedAtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateEmployeeFormCubit>();

    return BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'اسم الموظف',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                      errorText: state.nameError,
                    ),
                    onChanged: cubit.updateName,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(child: EditEmployeeRoleDropdown()),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _birthdateCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'تاريخ الميلاد',
                      prefixIcon: const Icon(Icons.cake_outlined),
                      border: const OutlineInputBorder(),
                      errorText: state.birthdateError,
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(state.birthdate) ?? DateTime(1995),
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        String formatted = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        _birthdateCtrl.text = formatted;
                        cubit.updateBirthdate(formatted);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _joinedAtCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'تاريخ الانضمام',
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      border: const OutlineInputBorder(),
                      errorText: state.joinedAtError,
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(state.joinedAt ) ?? DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        String formatted = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        _joinedAtCtrl.text = formatted;
                        cubit.updateJoinedAt(formatted);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const EditEmployeeDepartmentsSection(),
          ],
        );
      },
    );
  }
}