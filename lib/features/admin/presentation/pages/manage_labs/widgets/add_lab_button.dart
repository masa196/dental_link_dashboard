import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/create_new_lab/create_new_lab_dialog.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class AddLabButton extends StatelessWidget {
  const AddLabButton({super.key});

  Future<void> _onPressed(BuildContext context) async {
    final result = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CreateNewLabDialog(),
    );

    if (!context.mounted) return;

    if (result != null) {
      AppSnackbarHelper.showSuccess(
        context,
        title: context.l10n.success,
        message: result,
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!context.mounted) return;

        final uiState = context.read<ManageLabsCubit>().state;

        context.read<ManageLabsBloc>().add(
          ManageLabsFetchRequested(
            tab: uiState.selectedTab,
            page: uiState.currentPage,
            perPage: ManageLabsCubit.pageSize,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => _onPressed(context),
      icon: const Icon(
        Icons.add_circle,
        size: AppSpacing.md,
      ),
      label: Text(context.l10n.addNewLab),
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
    );
  }
}