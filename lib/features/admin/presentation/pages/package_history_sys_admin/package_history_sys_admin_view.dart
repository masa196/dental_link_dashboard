import 'package:dental_link_dashboard/features/admin/domain/entities/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/package_history_sys_admin/widgets/package_history_sys_admin_card.dart';
import 'package:dental_link_dashboard/shared/pagination/floating_pagination.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/package_history_sys_admin/package_history_sys_admin_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/package_history_sys_admin/widgets/package_history_sys_admin_header.dart';

class PackageHistorySysAdminView extends StatelessWidget {
  const PackageHistorySysAdminView({
    super.key,
    required this.labId,
    required this.labName,
  });

  final int labId;
  final String labName;


@override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final bool shortHeight = constraints.maxHeight < 350;

      if (shortHeight) {
        return SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth,
            child: Column(
              children: [
                PackageHistorySysAdminHeader(
                  labId: labId,
                  labName: labName,
                ),

                const SizedBox(height: AppSpacing.lg),

                _PackageHistoryBody(
                  labId: labId,
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: [
          PackageHistorySysAdminHeader(
            labId: labId,
            labName: labName,
          ),

          const SizedBox(height: AppSpacing.lg),

          Expanded(
            child: _PackageHistoryBody(
              labId: labId,
            ),
          ),
        ],
      );
    },
  );
}
}

class _PackageHistoryBody extends StatelessWidget {
  const _PackageHistoryBody({
    required this.labId,
  });

  final int labId;

  static const double _minCardWidth = 600;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        PackageHistorySysAdminBloc,
        PackageHistorySysAdminState>(
      builder: (context, state) {
        if (state.isLoading && state.response == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.failure != null && state.response == null) {
          return _PackageHistoryError(
            labId: labId,
          );
        }

        final items = state.response?.data?.data ?? [];

        if (items.isEmpty) {
          return Center(
            child: Text(
              context.isArabic
                  ? 'لا يوجد سجل باقات لهذا المخبر'
                  : 'No package history available',
            ),
          );
        }

       

        return LayoutBuilder(
  builder: (context, constraints) {
    final double availableWidth = constraints.maxWidth;

    final bool isVeryNarrow =
        availableWidth < _minCardWidth;

    final pagination = state.response?.data;

    final int currentPage =
        pagination?.currentPage ?? 1;

    final int totalPages =
        pagination?.lastPage ?? 1;

    final Widget content = Column(
      children: [
        if (state.isLoading)
          const LinearProgressIndicator(
            minHeight: 2,
          ),

        const SizedBox(height: AppSpacing.sm),

        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.md,
            ),
            child: PackageHistorySysAdminCard(
              item: item,
              availableWidth: isVeryNarrow
                  ? _minCardWidth
                  : availableWidth,
            ),
          ),
        ),

        if (totalPages > 1) ...[
          const SizedBox(height: AppSpacing.sm),

          FloatingPagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (page) {
              context.read<PackageHistorySysAdminBloc>().add(
                GetPackageHistorySysAdminRequested(
                  parameters: ShowPackageHistorySysAdminEntity(
                    labId: labId,
                    page: page,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: AppSpacing.lg),
        ],
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.lg,
      ),
      child: isVeryNarrow
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: _minCardWidth,
                child: content,
              ),
            )
          : content,
    );
  },
);
      },
    );
  }
}

class _PackageHistoryError extends StatelessWidget {
  const _PackageHistoryError({
    required this.labId,
  });

  final int labId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.isArabic
                  ? 'تعذر تحميل سجل الباقات'
                  : 'Unable to load package history',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.md),

            TextButton(
              onPressed: () {
                context.read<PackageHistorySysAdminBloc>().add(
                  GetPackageHistorySysAdminRequested(
                    parameters: ShowPackageHistorySysAdminEntity(
                      labId: labId,
                      page: 1,
                    ),
                  ),
                );
              },
              child: Text(
                context.isArabic
                    ? 'إعادة المحاولة'
                    : 'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }
}