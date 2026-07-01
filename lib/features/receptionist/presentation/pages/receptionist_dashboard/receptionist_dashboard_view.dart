import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dashboard_header/dashboard_header.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/models/dashboard_tab_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/pagination/floating_pagination.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/orders_list.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/tabs/dashboard_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionistDashboardView extends StatelessWidget {
  const ReceptionistDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      DashboardTabModel(title: "طلبات جديدة", count: ""),
      DashboardTabModel(title: "طلبات قيد الانتظار", count: ""),
      DashboardTabModel(title: "طلبات قيد التنفيذ", count: ""),
      DashboardTabModel(title: "طلبات بحاجة لإعادة", count: ""),
      DashboardTabModel(title: "طلبات بحاجة للتجربة", count: ""),
      DashboardTabModel(title: "طلبات جاهزة للإرسال", count: ""),
    ];

    return Column(
      children: [
        DashboardHeader(
          showMenuButton: false,
          onSearch: (_) {},
          onNotificationTap: () {},
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),
            child: Column(
              children: [
                BlocBuilder<
                    ReceptionistDashboardCubit,
                    ReceptionistDashboardState>(
                  builder: (context, dashboardState) {
                    return DashboardTabs(
                      tabs: tabs,
                      selectedIndex: dashboardState.selectedTab.index,
                      onTap: (index) {
                        final tab = ReceptionistOrderTab.values[index];

                        context
                            .read<ReceptionistDashboardCubit>()
                            .changeTab(tab);

                        context.read<ShowOrdersBloc>().add(
                              ShowOrdersRequested(
                                status: tab.apiStatus,
                              ),
                            );
                      },
                    );
                  },
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: OrdersList(
                    buttonTitle: "اطبع QR Code لبدء العمل",
                  ),
                ),

                const SizedBox(height: 16),

                BlocBuilder<ShowOrdersBloc, ShowOrdersState>(
                  builder: (context, state) {
                    if (state.lastPage <= 1) {
                      return const SizedBox.shrink();
                    }

                    return FloatingPagination(
                      currentPage: state.currentPage,
                      totalPages: state.lastPage,
                      onPageChanged: (page) {
                        context.read<ShowOrdersBloc>().add(
                              ShowOrdersRequested(
                                status: state.currentStatus!,
                                page: page,
                              ),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}