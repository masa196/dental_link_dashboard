import 'package:dental_link_dashboard/core/navigation/receptionist_layout.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/core/utils/file_downloader.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_state.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dashboard_header/dashboard_header.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/orders_filters_bar.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/tabs/dashboard_tab_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/pagination/floating_pagination.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/orders_list.dart';
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

    return MultiBlocListener(
      listeners: [
        BlocListener<PrintQrBloc, PrintQrState>(
          listener: (context, state) {
            if (state.status == PrintQrStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure?.message ?? 'حدث خطأ')),
              );
            }

            if (state.status == PrintQrStatus.success && state.image != null) {
              final serial = state.serialNumber ?? 'unknown';

              FileDownloader.downloadPng(
                state.image!,
                fileName: 'QR_$serial.png',
              );

              final ordersState = context.read<ShowOrdersBloc>().state;

              context.read<ShowOrdersBloc>().add(
                ShowOrdersRequested(
                  status: ordersState.currentStatus!,
                  page: ordersState.currentPage,
                ),
              );
            }
          },
        ),
        BlocListener<UpdateOrderStatusBloc, UpdateOrderStatusState>(
          listener: (context, state) {
            if (state.status == UpdateOrderStatusStatus.success) {
              AppSnackbarHelper.showSuccess(
                context,
                title: "نجاح",
                message: state.response?.message ?? "تم تحديث حالة الطلب",
              );

              final ordersState = context.read<ShowOrdersBloc>().state;

              context.read<ShowOrdersBloc>().add(
                ShowOrdersRequested(
                  status: ordersState.currentStatus!,
                  page: ordersState.currentPage,
                ),
              );
            }

            if (state.status == UpdateOrderStatusStatus.failure) {
              AppSnackbarHelper.showFailure(
                context,
                title: "خطأ",
                message: state.failure?.message ?? "فشل تحديث الحالة",
                failure: state.failure,
              );
            }
          },
        ),
      ],
      child: Column(
        children: [
          Builder(
            builder: (context) {
              return DashboardHeader(
                showMenuButton: !Responsive.isDesktop(context),
                onMenuPressed: ReceptionistLayoutScope.of(context).openDrawer,
                onSearch: (_) {},
                onNotificationTap: () {},
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  BlocBuilder<
                    ReceptionistDashboardCubit,
                    ReceptionistDashboardState
                  >(
                    builder: (context, dashboardState) {
                      return OrdersFiltersBar(
                        tabs: tabs,
                        selectedIndex: dashboardState.selectedTab.index,
                        onTabChanged: (index) {
                          final tab = ReceptionistOrderTab.values[index];

                          final dashboardCubit = context
                              .read<ReceptionistDashboardCubit>();

                          final ordersBloc = context.read<ShowOrdersBloc>();

                          dashboardCubit.changeTab(tab);

                          final isFirstTab =
                              tab == ReceptionistOrderTab.newOrders;

                          ordersBloc.add(
                            ShowOrdersRequested(
                              status: tab.apiStatus,
                              page: 1,

                              // 🔥 FIX: لا تربط ALL بأي priority
                              priority: isFirstTab
                                  ? null
                                  : ordersBloc.state.currentPriority,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Expanded(child: OrdersList(mode: OrdersMode.receptionist)),
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
      ),
    );
  }
}
