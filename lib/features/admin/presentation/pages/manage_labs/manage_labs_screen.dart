import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_header.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_stats.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_labs/widgets/manage_labs_table.dart';

class ManageLabsScreen extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenu;

  const ManageLabsScreen({
    super.key,
    this.onMenuTap,
    this.showMenu = false,
  });

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
        child: Column(
          children: [
            ManageLabsHeader(
              showMenu: showMenu,
              onMenuTap: onMenuTap,
            ),
            const SizedBox(height: AppSpacing.lg),
            const ManageLabsStats(),
            const SizedBox(height: AppSpacing.lg),
            const Expanded(child: ManageLabsTable()),
          ],
        ),
      ),
    );
  }
}