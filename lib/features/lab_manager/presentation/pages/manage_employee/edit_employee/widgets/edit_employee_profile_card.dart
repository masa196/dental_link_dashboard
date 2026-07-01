import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';

class EditEmployeeProfileCard extends StatelessWidget {
  const EditEmployeeProfileCard({
    super.key,
    required this.isArabic,
    required this.onPickImage,
  });

  final bool isArabic;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    const avatarSize = 124.0;

    return BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.16)),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [scheme.primary.withValues(alpha: 0.16), scheme.surfaceContainerLow],
                      ),
                      border: Border.all(color: scheme.primary.withValues(alpha: 0.22), width: 2.6),
                    ),
                    child: ClipOval(
                      child: state.profileImageBytes != null
                          ? Image.memory(state.profileImageBytes!, fit: BoxFit.cover)
                          : (state.profileImagePath != null && state.profileImagePath!.isNotEmpty
                              ? Image.network(state.profileImagePath!, fit: BoxFit.cover)
                              : Icon(Icons.person_rounded, size: 64, color: scheme.onSurface.withValues(alpha: 0.30))),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 2,
                    end: 2,
                    child: Material(
                      color: scheme.primary,
                      shape: const CircleBorder(),
                      elevation: 3,
                      child: InkWell(
                        onTap: onPickImage,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(9),
                          child: Icon(Icons.camera_alt_rounded, size: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                isArabic ? 'الصورة الشخصية' : 'Employee photo',
                style: TextStyle(fontSize: AppTypography.fs14, fontWeight: FontWeight.w700, color: scheme.onSurface),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onPickImage,
                  icon: const Icon(Icons.upload_rounded, size: 18),
                  label: Text(isArabic ? 'رفع صورة جديدة' : 'Upload new photo'),
                  style: FilledButton.styleFrom(
                    backgroundColor: scheme.primary.withValues(alpha: 0.10),
                    foregroundColor: scheme.primary,
                    elevation: 0,
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                  ),
                ),
              ),
              if (state.profileImageError != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.profileImageError!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: scheme.error),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}