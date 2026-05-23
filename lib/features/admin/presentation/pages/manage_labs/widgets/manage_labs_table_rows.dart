import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/delete_lab_manager_action.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/edit_info_lab_dialog.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/lab_photo_network_image.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';

class ManageLabsHeaderRow extends StatelessWidget {
  const ManageLabsHeaderRow({
    super.key,
    required this.photoWidth,
    required this.columnWidth,
  });

  final double photoWidth;
  final double columnWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color headerBackground = isDark
        ? AppDarkColors.surfaceContainerHighest
        : AppLightColors.surfaceContainerHighest;

    return Container(
      color: headerBackground,
      height: AppSizes.tableRowHeight,
      child: Row(
        children: [
          SizedBox(
            width: photoWidth,
            child: ManageLabsHeaderCell(l10n.labLogo),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsHeaderCell(l10n.labName),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsHeaderCell(l10n.labManager),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsHeaderCell(l10n.phoneNumber),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsHeaderCell(l10n.address),
          ),

          SizedBox(width: columnWidth, child: ManageLabsHeaderCell(l10n.email)),

          SizedBox(
            width: AppSizes.tableActionsWidth,
            child: ManageLabsHeaderCell(l10n.tableActions),
          ),
        ],
      ),
    );
  }
}

class ManageLabsHeaderCell extends StatelessWidget {
  const ManageLabsHeaderCell(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppTypography.fs14,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ManageLabsDataRow extends StatelessWidget {
  const ManageLabsDataRow({
    super.key,
    required this.state,
    required this.index,
    required this.photoWidth,
    required this.columnWidth,
    required this.l10n,
  });

  final ManageLabsBlocState state;
  final int index;
  final double photoWidth;
  final double columnWidth;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final data = state.labs[index];

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color accent = isDark ? AppDarkColors.accent : AppLightColors.accent;

    return SizedBox(
      height: AppSizes.tableRowHeight,
      child: Row(
        children: [
          SizedBox(
            width: photoWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: _LabPhotoThumb(photoUrl: data.photo),
            ),
          ),

          SizedBox(
            width: columnWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.labName ?? data.name ?? '—',
                    style: TextStyle(
                      fontSize: AppTypography.fs14,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppSpacing.xxs),

                  Text(
                    data.licenseNumber?.toString() ?? '—',
                    style: TextStyle(
                      fontSize: AppTypography.fs10,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsBodyCell(data.manager?.name ?? '—'),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsBodyCell(data.phone ?? '—'),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsBodyCell(data.address ?? '—'),
          ),

          SizedBox(
            width: columnWidth,
            child: ManageLabsEmailCell(data.manager?.email ?? '—'),
          ),

          SizedBox(
            width: AppSizes.tableActionsWidth,
            child: ManageLabsActionsCell(
              l10n: l10n,
              state: state,
              index: index,
            ),
          ),
        ],
      ),
    );
  }
}

class ManageLabsBodyCell extends StatelessWidget {
  const ManageLabsBodyCell(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppTypography.fs14,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ManageLabsEmailCell extends StatelessWidget {
  const ManageLabsEmailCell(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppTypography.fs14,
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ManageLabsActionsCell extends StatelessWidget {
  const ManageLabsActionsCell({
    super.key,
    required this.l10n,
    required this.state,
    required this.index,
  });

  final AppLocalizations l10n;
  final ManageLabsBlocState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final data = state.labs[index];

    final Color actionColor = Theme.of(context).colorScheme.primary;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Tooltip(
            message: l10n.view,
            child: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                size: AppSpacing.lgMinus,
                color: actionColor,
              ),
              onPressed: () {},
            ),
          ),

          Tooltip(
            message: l10n.edit,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                size: AppSpacing.lgMinus,
                color: actionColor,
              ),
              onPressed: () async {
                final result = await showDialog<String?>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => EditInfoLabDialog(lab: data),
                );

                if (!context.mounted) {
                  return;
                }

                if (result != null) {
                  AppSnackbarHelper.showSuccess(
                    context,
                    title: context.l10n.success,
                    message: result,
                  );

                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (context.mounted) {
                      context.read<ManageLabsBloc>().add(
                        ManageLabsFetchRequested(
                          tab: context
                              .read<ManageLabsCubit>()
                              .state
                              .selectedTab,
                          page: context
                              .read<ManageLabsCubit>()
                              .state
                              .currentPage,
                          perPage: ManageLabsCubit.pageSize,
                        ),
                      );
                    }
                  });
                }
              },
            ),
          ),

          Tooltip(
            message: l10n.delete,
            child: IconButton(
              icon: Icon(
                Icons.remove_circle,
                size: AppSpacing.lgMinus,
                color: AppDarkColors.alert,
              ),
              onPressed: () {
                confirmAndDeleteLab(
                  context,
                  labId: data.id ?? 0,
                  labName: data.labName ?? data.name ?? '—',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LabPhotoThumb extends StatelessWidget {
  const _LabPhotoThumb({required this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return LabPhotoNetworkImage(
      photoUrl: photoUrl,
      width: 48,
      height: 48,
      borderRadius: 10,
    );
  }
}
