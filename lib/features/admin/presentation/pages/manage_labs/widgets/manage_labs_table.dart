import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_table_compact.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_table_footer.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_table_rows.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_table_tabs.dart';
import 'package:dental_link_dashboard/l10n/app_localizations.dart';

class ManageLabsTable extends StatelessWidget {
  const ManageLabsTable({super.key});

  static const double actionsWidth = AppSizes.tableActionsWidth;
  static const double photoWidth = 88;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ManageLabsBloc, ManageLabsBlocState>(
      builder: (context, remoteState) {
        return BlocBuilder<ManageLabsCubit, ManageLabsUiState>(
          builder: (context, uiState) {
            final footer = ManageLabsTableFooter(
              currentPage: uiState.currentPage,
              lastPage: remoteState.lastPage,
              from: remoteState.from,
              to: remoteState.to,
              total: remoteState.total,
              onPrevious: remoteState.hasData && uiState.currentPage > 1
                  ? () => context.read<ManageLabsCubit>().previousPage()
                  : null,
              onNext:
                  remoteState.hasData &&
                      uiState.currentPage < remoteState.lastPage
                  ? () => context.read<ManageLabsCubit>().nextPage(
                      lastPage: remoteState.lastPage,
                    )
                  : null,
            );

            return LayoutBuilder(
              builder: (context, constraints) {
                final double tableWidth = constraints.maxWidth;

                final bool compact = tableWidth < ScreenSizes.mobile;

                final bool hasRows = remoteState.labs.isNotEmpty;

                final bool showLoading = remoteState.isLoading && hasRows;

                if (compact) {
                  return ManageLabsCompactList(
                    state: remoteState,
                    footer: footer,
                    isLoading: remoteState.isLoading,
                    isFailure:
                        remoteState.status == ManageLabsRemoteStatus.failure,
                    onRetry: () {
                      context.read<ManageLabsBloc>().add(
                        ManageLabsFetchRequested(
                          tab: uiState.selectedTab,
                          page: uiState.currentPage,
                          perPage: ManageLabsCubit.pageSize,
                        ),
                      );
                    },
                  );
                }

                const double minDataColumnWidth =
                    AppSizes.tableMinDataColumnWidth;

                const double minTableWidth =
                    photoWidth + (minDataColumnWidth * 5) + actionsWidth;

                final double effectiveTableWidth = tableWidth < minTableWidth
                    ? minTableWidth
                    : tableWidth;

                final double columnWidth =
                    (effectiveTableWidth - actionsWidth - photoWidth) / 5;

                final Widget body = _TableBody(
                  remoteState: remoteState,
                  photoWidth: photoWidth,
                  columnWidth: columnWidth,
                  l10n: l10n,
                );

                final Widget table = DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: SizedBox(
                    width: effectiveTableWidth,
                    child: Column(
                      children: [
                        ManageLabsTableTabs(
                          l10n: l10n,
                          selectedTab: uiState.selectedTab,
                          onTabSelected: (tab) {
                            context.read<ManageLabsCubit>().selectTab(tab);
                          },
                        ),

                        Divider(
                          height: AppSizes.dividerThickness,
                          color: Theme.of(context).dividerColor,
                        ),

                        if (showLoading)
                          const LinearProgressIndicator(minHeight: 2),

                        body,

                        Divider(
                          height: AppSizes.dividerThickness,
                          color: Theme.of(context).dividerColor,
                        ),

                        footer,
                      ],
                    ),
                  ),
                );

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: table,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _TableBody extends StatelessWidget {
  const _TableBody({
    required this.remoteState,
    required this.photoWidth,
    required this.columnWidth,
    required this.l10n,
  });

  final ManageLabsBlocState remoteState;
  final double photoWidth;
  final double columnWidth;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    if (remoteState.isInitialLoading && remoteState.labs.isEmpty) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (remoteState.status == ManageLabsRemoteStatus.failure &&
        remoteState.labs.isEmpty) {
      return Expanded(
        child: Center(
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
                  onPressed: () {
                    context.read<ManageLabsBloc>().add(
                      ManageLabsFetchRequested(
                        tab: context.read<ManageLabsCubit>().state.selectedTab,
                        page: context.read<ManageLabsCubit>().state.currentPage,
                        perPage: ManageLabsCubit.pageSize,
                      ),
                    );
                  },
                  child: Text(context.isArabic ? 'إعادة المحاولة' : 'Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (remoteState.labs.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            context.isArabic ? 'لا توجد مخابر لعرضها' : 'No labs available',
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        children: [
          ManageLabsHeaderRow(photoWidth: photoWidth, columnWidth: columnWidth),
          Expanded(
            child: ListView.separated(
              itemCount: remoteState.labs.length,
              separatorBuilder: (_, _) => Divider(
                height: AppSizes.dividerThickness,
                color: Theme.of(context).dividerColor,
              ),
              itemBuilder: (_, index) {
                return ManageLabsDataRow(
                  state: remoteState,
                  index: index,
                  photoWidth: photoWidth,
                  columnWidth: columnWidth,
                  l10n: l10n,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
