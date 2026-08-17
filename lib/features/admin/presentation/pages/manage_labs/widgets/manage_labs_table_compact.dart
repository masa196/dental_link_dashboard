import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/delete_lab_manager_action.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/edit_info_lab_dialog.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/lab_photo_network_image.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';

class ManageLabsCompactList extends StatelessWidget {
  const ManageLabsCompactList({
    super.key,
    required this.state,
    required this.footer,
    required this.isLoading,
    required this.isFailure,
    required this.onRetry,
  });

  final ManageLabsBlocState state;
  final Widget footer;
  final bool isLoading;
  final bool isFailure;
  final VoidCallback onRetry;

  @override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  final borderColor = Theme.of(context).dividerColor;
  final background = Theme.of(context).cardColor;

  final labs = state.labs;

  return LayoutBuilder(
    builder: (context, constraints) {
      const double minCompactWidth = 300;

      final bool enableHorizontalScroll =
          constraints.maxWidth < minCompactWidth;

      final Widget content = SizedBox(
        width: enableHorizontalScroll
            ? minCompactWidth
            : constraints.maxWidth,
        child: Column(
          children: [
            Expanded(
              child: isLoading && labs.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : isFailure && labs.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.isArabic
                                  ? 'تعذر تحميل المخابر'
                                  : 'Unable to load labs',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextButton(
                              onPressed: onRetry,
                              child: Text(
                                context.isArabic
                                    ? 'إعادة المحاولة'
                                    : 'Retry',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : labs.isEmpty
                  ? Center(
                      child: Text(
                        context.isArabic
                            ? 'لا توجد مخابر لعرضها'
                            : 'No labs available',
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: labs.length,
                      separatorBuilder: (_, _) =>
                          Divider(
                            height: AppSpacing.lg,
                            color: borderColor,
                          ),
                      itemBuilder: (context, index) {
                        return ManageLabsCompactCard(
                          state: state,
                          index: index,
                          l10n: l10n,
                        );
                      },
                    ),
            ),

            if (isLoading && labs.isNotEmpty)
              const LinearProgressIndicator(
                minHeight: 2,
              ),

            footer,
          ],
        ),
      );

      return DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(
            AppRadius.xlPlus,
          ),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: enableHorizontalScroll
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: content,
              )
            : content,
      );
    },
  );
}
}

class ManageLabsCompactCard extends StatelessWidget {
  const ManageLabsCompactCard({
    super.key,
    required this.state,
    required this.index,
    required this.l10n,
  });

  final ManageLabsBlocState state;
  final int index;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final lab = state.labs[index];
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CompactPhoto(photoUrl: lab.photo),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.labName ?? lab.name ?? '—',
                    style: TextStyle(
                      fontSize: AppTypography.fs16,
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xsPlus),
                  Text(
                    lab.licenseNumber?.toString() ?? '—',
                    style: TextStyle(
                      fontSize: AppTypography.fs12,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.smPlus),

        _Detail(label: l10n.labManager, value: lab.manager?.name ?? '—'),
        _Detail(label: l10n.phoneNumber, value: lab.phone ?? '—'),
        _Detail(label: l10n.address, value: lab.address ?? '—'),
        _Detail(label: l10n.email, value: lab.manager?.email ?? '—'),

        const SizedBox(height: AppSpacing.smPlus),

        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                size: AppSpacing.lgMinus,
                color: scheme.primary,
              ),
              onPressed: () {},
            ),

            IconButton(
              icon: Icon(
                Icons.edit,
                size: AppSpacing.lgMinus,
                color: scheme.primary,
              ),
              onPressed: () async {
                final result = await showDialog<String?>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => EditInfoLabDialog(lab: lab),
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

                    final ui = context.read<ManageLabsCubit>().state;

                    context.read<ManageLabsBloc>().add(
                      ManageLabsFetchRequested(
                        tab: ui.selectedTab,
                        page: ui.currentPage,
                        perPage: ManageLabsCubit.pageSize,
                      ),
                    );
                  });
                }
              },
            ),

            IconButton(
              icon: Icon(
                Icons.remove_circle,
                size: AppSpacing.lgMinus,
                color: AppDarkColors.alert,
              ),
              onPressed: () {
                confirmAndDeleteLab(
                  context,
                  labId: lab.id ?? 0,
                  labName: lab.labName ?? lab.name ?? '—',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _CompactPhoto extends StatelessWidget {
  const _CompactPhoto({required this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return LabPhotoNetworkImage(
      photoUrl: photoUrl,
      width: 60,
      height: 60,
      borderRadius: 12,
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: AppTypography.fs13,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
