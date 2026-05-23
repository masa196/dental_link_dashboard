import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/create_new_lab/create_new_lab_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class ManageLabsHeader extends StatelessWidget {
  const ManageLabsHeader({super.key, this.showMenu = false, this.onMenuTap});

  final bool showMenu;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showMenu)
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu),
                iconSize: AppSpacing.lgMinus,
                color: context.scheme.primary,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppSizes.menuButtonMinSize,
                  minHeight: AppSizes.menuButtonMinSize,
                ),
              ),

            if (showMenu) const SizedBox(width: AppSpacing.xs),

            Expanded(
              child: Text(
                l10n.manageLabsTitle,
                style: TextStyle(
                  fontSize: AppTypography.fs24,
                  fontWeight: FontWeight.w700,
                  color: context.scheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            FittedBox(
              fit: BoxFit.scaleDown,
              child: FilledButton.icon(
                onPressed: () async {
                  final result = await showDialog<String?>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const CreateNewLabDialog(),
                  );

                  if (!context.mounted) return;

                  /// 🔥 النجاح: عرض رسالة السيرفر ثم refresh
                  if (result != null) {
                    AppSnackbarHelper.showSuccess(
                      context,
                      title: context.l10n.success,
                      message: result,
                    );

                    // ✅ عمل Refresh بعد النجاح
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (context.mounted) {
                        final uiState = context.read<ManageLabsCubit>().state;

                        context.read<ManageLabsBloc>().add(
                          ManageLabsFetchRequested(
                            tab: uiState.selectedTab,
                            page: uiState.currentPage,
                            perPage: ManageLabsCubit.pageSize,
                          ),
                        );
                      }
                    });
                  }
                  // ❌ في حالة الفشل: الـ dialog يعرض الخطأ بنفسه قبل الإغلاق
                },

                icon: const Icon(Icons.add_circle, size: AppSpacing.md),

                label: Text(l10n.addNewLab),

                style: FilledButton.styleFrom(
                  backgroundColor: context.scheme.primary,
                  foregroundColor: context.scheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.mdMinus,
                  ),
                  textStyle: const TextStyle(
                    fontSize: AppTypography.fs14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xsPlus),

        Text(
          l10n.manageLabsSubtitle,
          style: TextStyle(
            fontSize: AppTypography.fs14,
            color: context.scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
