import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/create_role/bloc/create_role_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/create_role/bloc/create_role_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/create_role/bloc/create_role_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/create_role_entity/create_role_entity.dart';

import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/all_permissions_model.dart';

class CreateRoleDialog extends StatefulWidget {
  final List<Permission> permissions;

  const CreateRoleDialog({super.key, required this.permissions});

  @override
  State<CreateRoleDialog> createState() => _CreateRoleDialogState();
}

class _CreateRoleDialogState extends State<CreateRoleDialog> {
  final TextEditingController _nameController = TextEditingController();

  final Set<int> _selectedPermissions = {};
  bool _isSubmitting = false;

  void _toggle(int id) {
    setState(() {
      if (_selectedPermissions.contains(id)) {
        _selectedPermissions.remove(id);
      } else {
        _selectedPermissions.add(id);
      }
    });
  }

  String? _nameError;
  void _submit() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _nameError = "Role name is required";
      });
      return;
    }

    if (_selectedPermissions.isEmpty) return;

    setState(() => _isSubmitting = true);

    final entity = CreateRoleEntity(
      name: name,
      permissions: _selectedPermissions.toList(),
    );

    context.read<CreateRoleBloc>().add(SubmitCreateRoleEvent(entity));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<CreateRoleBloc, CreateRoleState>(
      listener: (context, state) {
        if (state.isSuccess) {
          setState(() => _isSubmitting = false);

          // 1. عرض رسالة النجاح (بنفس نظامك الاحترافي)
          AppSnackbarHelper.showSuccess(
            context,
            title: "Success",
            message: state.message ?? "Role created successfully",
          );

          // 2. تأخير بسيط حتى تُعرض الرسالة
          Future.delayed(const Duration(milliseconds: 600), () {
            if (context.mounted) {
              Navigator.pop(context, true);
            }
          });
        }

        if (state.failure != null) {
          setState(() => _isSubmitting = false);

          AppSnackbarHelper.showFailure(
            context,
            title: "Error",
            message: state.failure!.message,
            failure: state.failure,
          );
        }

        if (state.isLoading) {
          setState(() => _isSubmitting = true);
        }
      },
      child: AlertDialog(
        title: const Text("Create Role"),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                onChanged: (_) {
                  if (_nameError != null) {
                    setState(() => _nameError = null);
                  }
                },
                decoration: InputDecoration(
                  labelText: "Role Name",
                  errorText: _nameError,
                ),
              ),

              const SizedBox(height: 16),

              const Text("Permissions"),

              const SizedBox(height: 8),

              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: widget.permissions.length,
                  itemBuilder: (context, i) {
                    final p = widget.permissions[i];

                    final selected = _selectedPermissions.contains(p.id);

                    return CheckboxListTile(
                      value: selected,
                      title: Text(p.name ?? ''),
                      onChanged: p.id == null ? null : (_) => _toggle(p.id!),
                      activeColor: scheme.primary,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed:
                (_isSubmitting ||
                    _nameController.text.trim().isEmpty ||
                    _selectedPermissions.isEmpty)
                ? null
                : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Create"),
          ),
        ],
      ),
    );
  }
}
