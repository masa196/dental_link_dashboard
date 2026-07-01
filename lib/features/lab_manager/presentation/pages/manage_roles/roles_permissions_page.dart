import 'package:dental_link_dashboard/core/navigation/lab_manager_layout.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/all_permissions_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/matrix_roles_and_permissions/matrix_roles_and_permissions_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/matrix_roles_entity/matrix_roles_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/create_role/bloc/create_role_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/delete_role/bloc/delete_role_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/delete_role/bloc/delete_role_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/delete_role/bloc/delete_role_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_all_permissions/bloc/get_all_permissions_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_all_permissions/bloc/get_all_permissions_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_all_permissions/bloc/get_all_permissions_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_matrix_roles_and_permissions/get_matrix_roles_and_permissions_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_matrix_roles_and_permissions/get_matrix_roles_and_permissions_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/get_matrix_roles_and_permissions/get_matrix_roles_and_permissions_state.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/update_matrix_roles_and_permissions/update_matrix_roles_and_permissions_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/update_matrix_roles_and_permissions/update_matrix_roles_and_permissions_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_roles/update_matrix_roles_and_permissions/update_matrix_roles_and_permissions_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_roles/widgets/create_role_dialog.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

import 'package:dental_link_dashboard/shared/widgets/side_nav_menu_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';

import 'widgets/matrix_header.dart';
import 'widgets/permission_row.dart';

class RolesPermissionsPage extends StatelessWidget {
  const RolesPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              locator<GetMatrixRolesAndPermissionsBloc>()
                ..add(const LoadMatrixRolesAndPermissions()),
        ),

        BlocProvider(
          create: (_) =>
              locator<GetAllPermissionsBloc>()..add(const LoadAllPermissions()),
        ),

        BlocProvider(
          create: (_) => locator<UpdateMatrixRolesAndPermissonsBloc>(),
        ),

        BlocProvider(create: (_) => locator<CreateRoleBloc>()),
        BlocProvider(create: (_) => locator<DeleteRoleBloc>()),
      ],
      child: const _RolesPermissionsView(),
    );
  }
}

class _RolesPermissionsView extends StatefulWidget {
  const _RolesPermissionsView();

  @override
  State<_RolesPermissionsView> createState() => _RolesPermissionsViewState();
}

class _RolesPermissionsViewState extends State<_RolesPermissionsView> {
  bool _isEditing = false;

  final Map<int, Set<int>> _editedMatrix = {};
  final Map<String, int> _permissionNameToId = {};

  // =========================
  // EDITING
  // =========================

  void _startEditing(List<Matrix> matrix) {
    _editedMatrix.clear();

    for (final role in matrix) {
      final roleId = role.id;
      if (roleId == null) continue;

      final ids = <int>{};

      for (final name in role.permissions ?? []) {
        final id = _permissionNameToId[name];
        if (id != null) ids.add(id);
      }

      _editedMatrix[roleId] = ids;
    }

    setState(() => _isEditing = true);
  }

  void _cancelEditing() {
    _editedMatrix.clear();
    setState(() => _isEditing = false);
  }

  void _togglePermission(int roleId, int permissionId) {
    final set = _editedMatrix.putIfAbsent(roleId, () => <int>{});

    setState(() {
      if (set.contains(permissionId)) {
        set.remove(permissionId);
      } else {
        set.add(permissionId);
      }
    });
  }

  void _submit() {
    final params = MatrixRolesEntity(
      matrix: _editedMatrix.entries.map((e) {
        return MatrixRoleItemEntity(
          roleId: e.key,
          permissions: e.value.toList(),
        );
      }).toList(),
    );

    context.read<UpdateMatrixRolesAndPermissonsBloc>().add(
      SubmitMatrixEvent(params),
    );
  }

  // =========================
  // DELETE ROLE (IMPORTANT)
  // =========================

  void _deleteRole(int roleId, String roleName) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Delete Role"),
          content: Text(
            'Are you sure you want to delete "$roleName"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(ctx);

                context.read<DeleteRoleBloc>().add(
                  SubmitDeleteRoleEvent(roleId),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteRoleDialog(List<Matrix> roles) {
    int? selectedRoleId;
    String? selectedRoleName;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Delete Role"),
              content: DropdownButtonFormField<int>(
                initialValue: selectedRoleId,
                decoration: const InputDecoration(labelText: "Select Role"),
                items: roles
                    .where((e) => e.id != null)
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: e.id!,
                        child: Text(e.name ?? ''),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setStateDialog(() {
                    selectedRoleId = value;

                    final role = roles.firstWhere((e) => e.id == value);

                    selectedRoleName = role.name ?? '';
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: selectedRoleId == null
                      ? null
                      : () {
                          Navigator.pop(dialogContext);

                          _deleteRole(selectedRoleId!, selectedRoleName ?? '');
                        },
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;
    final isMobile = Responsive.isMobile(context);

    return MultiBlocListener(
      listeners: [
        // UPDATE MATRIX
        BlocListener<
          UpdateMatrixRolesAndPermissonsBloc,
          UpdateMatrixRolesAndPermissonsState
        >(
          listener: (context, state) {
            if (state.isSuccess) {
              _cancelEditing();

              context.read<GetMatrixRolesAndPermissionsBloc>().add(
                const LoadMatrixRolesAndPermissions(),
              );

              AppSnackbarHelper.showSuccess(
                context,
                title: "Success",
                message: state.message ?? "Updated successfully",
              );
            }

            if (state.failure != null) {
              AppSnackbarHelper.showFailure(
                context,
                title: "Error",
                message: state.failure!.message,
                failure: state.failure,
              );
            }
          },
        ),

        // DELETE ROLE
        BlocListener<DeleteRoleBloc, DeleteRoleState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.read<GetMatrixRolesAndPermissionsBloc>().add(
                const LoadMatrixRolesAndPermissions(),
              );

              AppSnackbarHelper.showSuccess(
                context,
                title: "Deleted",
                message: state.message ?? "Role deleted successfully",
              );

              context.read<DeleteRoleBloc>().add(const ResetDeleteRoleState());
            }

            if (state.failure != null) {
              AppSnackbarHelper.showFailure(
                context,
                title: "Error",
                message: state.failure!.message,
                failure: state.failure,
              );

              context.read<DeleteRoleBloc>().add(const ResetDeleteRoleState());
            }
          },
        ),
      ],
      child:
          BlocBuilder<
            GetMatrixRolesAndPermissionsBloc,
            GetMatrixRolesAndPermissionsState
          >(
            builder: (context, matrixState) {
              if (matrixState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (matrixState.isFailure) {
                return Center(
                  child: Text(matrixState.failure?.message ?? "Error"),
                );
              }

              return BlocBuilder<GetAllPermissionsBloc, GetAllPermissionsState>(
                builder: (context, permissionState) {
                  final matrix = matrixState.response?.data?.matrix ?? [];
                  final permissions =
                      permissionState.response?.data?.permissions ?? [];

                  _permissionNameToId
                    ..clear()
                    ..addEntries(
                      permissions.map((e) => MapEntry(e.name ?? '', e.id ?? 0)),
                    );

                  return Column(
                    children: [
                      _HeaderSection(isArabic: isArabic, scheme: scheme),

                      const SizedBox(height: 12),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 24,
                          ),
                          child: _MatrixTable(
                            matrix: matrix,
                            permissions: permissions,
                            isArabic: isArabic,
                            scheme: scheme,
                            isEditing: _isEditing,
                            editedMatrix: _editedMatrix,
                            onPermissionChanged: _togglePermission,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (!_isEditing)
                            FilledButton.icon(
                              onPressed: () => _startEditing(matrix),
                              icon: const Icon(Icons.edit),
                              label: Text(isArabic ? "تعديل" : "Edit"),
                            ),

                          if (!_isEditing)
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () => _showDeleteRoleDialog(matrix),
                              icon: const Icon(Icons.delete_outline),
                              label: Text(isArabic ? "حذف دور" : "Delete Role"),
                            ),

                          if (_isEditing)
                            OutlinedButton(
                              onPressed: _cancelEditing,
                              child: Text(isArabic ? "إلغاء" : "Cancel"),
                            ),

                          if (_isEditing)
                            FilledButton.icon(
                              onPressed: _submit,
                              icon: const Icon(Icons.save),
                              label: Text(isArabic ? "حفظ" : "Save"),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),
                    ],
                  );
                },
              );
            },
          ),
    );
  }
}

class _MatrixTable extends StatelessWidget {
  const _MatrixTable({
    required this.matrix,
    required this.permissions,
    required this.isArabic,
    required this.scheme,
    required this.isEditing,
    required this.editedMatrix,
    required this.onPermissionChanged,
  });

  final List<Matrix> matrix;
  final List<Permission> permissions;

  final bool isArabic;
  final ColorScheme scheme;

  final bool isEditing;

  /// roleId -> permissionIds
  final Map<int, Set<int>> editedMatrix;

  final void Function(int roleId, int permissionId) onPermissionChanged;

  @override
  Widget build(BuildContext context) {
    final roles = matrix
        .map((e) => RoleColumnModel(id: e.id ?? 0, name: e.name ?? ''))
        .toList();

    /// أثناء العرض العادي
    /// نبني الخريطة من الـ Matrix API
    final rolePermissions = <int, Set<int>>{};

    /// name -> id
    final permissionMap = {
      for (final p in permissions)
        if (p.name != null && p.id != null) p.name!: p.id!,
    };

    for (final role in matrix) {
      final ids = <int>{};

      for (final permissionName in role.permissions ?? []) {
        final id = permissionMap[permissionName];

        if (id != null) {
          ids.add(id);
        }
      }

      rolePermissions[role.id ?? 0] = isEditing
          ? (editedMatrix[role.id ?? 0] ?? <int>{})
          : ids;
    }

    const permissionWidth = 260.0;
    const minRoleWidth = 120.0;

    final safeRoles = roles.isEmpty ? 1 : roles.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final roleWidth = ((constraints.maxWidth - permissionWidth) / safeRoles)
            .clamp(minRoleWidth, double.infinity);

        final totalWidth = permissionWidth + roleWidth * safeRoles;

        return Card(
          elevation: 0,
          color: scheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: scheme.outline.withValues(alpha: .12)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: totalWidth,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        border: Border(
                          bottom: BorderSide(
                            color: scheme.outline.withValues(alpha: .2),
                          ),
                        ),
                      ),
                      child: MatrixHeader(
                        roles: roles.map((e) => e.name).toList(),
                        permissionWidth: permissionWidth,
                        roleWidth: roleWidth,
                        isArabic: isArabic,
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: permissions.length,
                        itemBuilder: (context, index) {
                          final permission = permissions[index];

                          return PermissionRow(
                            permissionName: permission.name ?? '',

                            permissionId: permission.id ?? 0,

                            roles: roles,

                            rolePermissions: rolePermissions,

                            permissionWidth: permissionWidth,

                            roleWidth: roleWidth,

                            zebra: index.isEven,

                            scheme: scheme,

                            isEditing: isEditing,

                            onTogglePermission: onPermissionChanged,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final bool isArabic;
  final ColorScheme scheme;

  const _HeaderSection({required this.isArabic, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outline.withValues(alpha: .10)),
      ),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            SideNavMenuButton(onTap: LayoutScope.of(context).openDrawer),

          const SizedBox(width: 8),

          Icon(
            Icons.admin_panel_settings_outlined,
            color: scheme.primary,
            size: 24,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isArabic ? "الأدوار والصلاحيات" : "Roles & Permissions",
                  style: TextStyle(
                    fontSize: AppTypography.fs24,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isArabic
                      ? "إدارة أدوار النظام والصلاحيات"
                      : "Manage roles and permissions",
                  style: TextStyle(
                    fontSize: AppTypography.fs13,
                    color: scheme.onSurface.withValues(alpha: .60),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton.icon(
            onPressed: () async {
              final permissions =
                  context
                      .read<GetAllPermissionsBloc>()
                      .state
                      .response
                      ?.data
                      ?.permissions ??
                  [];

              final result = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return BlocProvider.value(
                    value: context.read<CreateRoleBloc>(),
                    child: CreateRoleDialog(permissions: permissions),
                  );
                },
              );

              if (!context.mounted) return;

              if (result == true) {
                context.read<GetMatrixRolesAndPermissionsBloc>().add(
                  const LoadMatrixRolesAndPermissions(),
                );

                context.read<GetAllPermissionsBloc>().add(
                  const LoadAllPermissions(),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Role"),
          ),
        ],
      ),
    );
  }
}
