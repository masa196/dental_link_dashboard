import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/lab_statistics/lab_statistics_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/lab_statistics/lab_statistics_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/add_lab_button.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/labs_statistics.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_table.dart';

class ManageLabsScreen extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenu;

  const ManageLabsScreen({
    super.key,
    this.onMenuTap,
    this.showMenu = false,
  });

  static const double shortHeightThreshold = 400;
  static const double shortHeightTable = 300;

  @override
  Widget build(BuildContext context) {
    final cubit = locator<ManageLabsCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => cubit),
        BlocProvider(
          create: (_) => locator<ManageLabsBloc>()
            ..add(
              ManageLabsFetchRequested(
                tab: cubit.state.selectedTab,
                page: cubit.state.currentPage,
                perPage: ManageLabsCubit.pageSize,
              ),
            ),
        ),
        BlocProvider(
          create: (_) => locator<LabStatisticsBloc>()
            ..add(const LabStatisticsFetchRequested()),
        ),
      ],
      child: BlocListener<ManageLabsCubit, ManageLabsUiState>(
        listenWhen: (previous, current) =>
            previous.selectedTab != current.selectedTab ||
            previous.currentPage != current.currentPage,
        listener: (context, state) {
          context.read<ManageLabsBloc>().add(
                ManageLabsFetchRequested(
                  tab: state.selectedTab,
                  page: state.currentPage,
                  perPage: ManageLabsCubit.pageSize,
                ),
              );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isShortHeight =
                constraints.maxHeight < shortHeightThreshold;

            final header = DashboardHeader(
              title: context.l10n.manageLabsTitle,
              showMenuButton: !Responsive.isDesktop(context),
              showSearchBar: false,
              showNotification: false,
              trailing: const AddLabButton(),
            );

            final statistics = const LabsStatistics();

            // Normal height
            if (!isShortHeight) {
              return Column(
                children: [
                  header,
                  const SizedBox(height: AppSpacing.lg),
                  statistics,
                  const SizedBox(height: AppSpacing.lg),
                  const Expanded(
                    child: ManageLabsTable(),
                  ),
                ],
              );
            }

            // Short height:
            // Header + statistics + table become vertically scrollable.
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,

                  const SizedBox(height: AppSpacing.lg),

                  statistics,

                  const SizedBox(height: AppSpacing.lg),

                  const SizedBox(
                    height: shortHeightTable,
                    child: ManageLabsTable(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}