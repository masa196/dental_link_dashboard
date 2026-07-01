import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_roles/widgets/permission_checkbox.dart';
import 'package:flutter/material.dart';

class PermissionRow extends StatefulWidget {
  const PermissionRow({
    super.key,
    required this.permissionName,
    required this.permissionId,
    required this.roles,
    required this.rolePermissions,
    required this.permissionWidth,
    required this.roleWidth,
    required this.zebra,
    required this.scheme,
    required this.isEditing,
    required this.onTogglePermission,
  });

  final String permissionName;
  final int permissionId;

  final List<RoleColumnModel> roles;

  final Map<int, Set<int>> rolePermissions;

  final double permissionWidth;
  final double roleWidth;
  final bool zebra;
  final ColorScheme scheme;

  final bool isEditing;

  final void Function(int roleId, int permissionId) onTogglePermission;

  @override
  State<PermissionRow> createState() => _PermissionRowState();
}

class _PermissionRowState extends State<PermissionRow> {
  final ValueNotifier<bool> _hover = ValueNotifier(false);

  @override
  void dispose() {
    _hover.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.zebra
        ? widget.scheme.surfaceContainerHighest.withValues(alpha: .10)
        : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => _hover.value = true,
      onExit: (_) => _hover.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _hover,
        builder: (_, hover, __) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            color: hover
                ? widget.scheme.primary.withValues(alpha: .08)
                : baseColor,
            child: Row(
              children: [
                
                _cell(
                  width: widget.permissionWidth,
                  child: Text(
                    widget.permissionName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: widget.scheme.onSurface,
                    ),
                  ),
                ),

                ...widget.roles.map((role) {
                  final roleId = role.id;

                  final isChecked =
                      widget.rolePermissions[roleId]?.contains(
                        widget.permissionId,
                      ) ??
                      false;

                  return _cell(
                    width: widget.roleWidth,
                    rightBorder: true,
                    child: widget.isEditing
                        ? PermissionCheckbox(
                            value: isChecked,
                            onChanged: (value) {
                              widget.onTogglePermission(
                                roleId,
                                widget.permissionId,
                              );
                            },
                          )
                        : isChecked
                        ? Icon(
                            Icons.task_alt,
                            size: 18,
                            color: widget.scheme.primary,
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _cell({
    required double width,
    required Widget child,
    bool rightBorder = false,
  }) {
    return Container(
      width: width,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: rightBorder
              ? BorderSide(color: widget.scheme.outline)
              : BorderSide.none,
          bottom: BorderSide(color: widget.scheme.outline),
        ),
      ),
      child: child,
    );
  }
}

class RoleColumnModel {
  const RoleColumnModel({required this.id, required this.name});

  final int id;
  final String name;
}
