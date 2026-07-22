import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/create_delivery_assignment_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/update_order_status_entity.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/create_delivery_assignment/create_delivery_assignment_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/create_delivery_assignment/create_delivery_assignment_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/create_delivery_assignment/create_delivery_assignment_state.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/manage_delivery/show_delivery_employees/show_delivery_employees_state.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_state.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/print_qr/print_qr_event.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/update_order_status/update_order_status_state.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_cubit.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/cubit/receptionist_dashboard_state.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dialogs/show_delivery_employee_dialog.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/dialogs/update_order_status_dialog.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/order_card/order_card.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/receptionist_dashboard/shared/dashboard_action_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersList extends StatelessWidget {
  final OrdersMode mode;

  const OrdersList({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final isLabManager = mode == OrdersMode.labManager;

    return _buildBody(context, isLabManager);
  }

  Widget _buildBody(BuildContext context, bool isLabManager) {
    // ===========================================================
    // LAB MANAGER
    // ===========================================================

    if (isLabManager) {
      return BlocBuilder<
        ReceptionistDashboardCubit,
        ReceptionistDashboardState
      >(
        builder: (context, dashboardState) {
          final dashboardCubit = context.read<ReceptionistDashboardCubit>();

          final selectedTab = dashboardState.selectedTab;

          final buttonTitle = dashboardCubit.getButtonTitle(selectedTab);

          final showWorkflow = dashboardCubit.shouldUseWorkflow(selectedTab);

          return BlocBuilder<ShowOrdersBloc, ShowOrdersState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.failure != null) {
                return Center(child: Text(state.failure!.message));
              }

              if (state.orders.isEmpty) {
                return const Center(child: Text("No orders found"));
              }

              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];

                  return OrderCard(
                    order: order,
                    actionWidget: DashboardActionButton(
                      title: "عرض التفاصيل",
                      onPressed: () {
                        OrderDetailsRoute(orderId: order.id!).push(context);
                      },
                    ),
                    showWorkflow: showWorkflow,
                    buttonTitle: buttonTitle,
                  );
                },
              );
            },
          );
        },
      );
    }

    // ===========================================================
    // RECEPTIONIST
    // ===========================================================

    return MultiBlocListener(
      listeners: [
        BlocListener<
          CreateDeliveryAssignmentBloc,
          CreateDeliveryAssignmentState
        >(
          listener: (context, state) {
            if (state.status == CreateDeliveryAssignmentStatus.success) {
              AppSnackbarHelper.showSuccess(
                context,
                title: "نجاح",
                message:
                    state.response?.message ?? "تم إنشاء مهمة التوصيل بنجاح",
              );

              final ordersState = context.read<ShowOrdersBloc>().state;

              context.read<ShowOrdersBloc>().add(
                ShowOrdersRequested(
                  status: ordersState.currentStatus!,
                  page: ordersState.currentPage,
                ),
              );
            }

            if (state.status == CreateDeliveryAssignmentStatus.failure) {
              AppSnackbarHelper.showFailure(
                context,
                title: "خطأ",
                message: state.failure?.message ?? "فشل إنشاء مهمة التوصيل",
                failure: state.failure,
              );
            }
          },
        ),
      ],

      child: BlocBuilder<ShowOrdersBloc, ShowOrdersState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failure != null) {
            return Center(child: Text(state.failure!.message));
          }

          if (state.orders.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          final dashboardCubit = context.watch<ReceptionistDashboardCubit>();

          final selectedTab = dashboardCubit.state.selectedTab;

          final deliveryEmployeesState = context
              .watch<ShowDeliveryEmployeesBloc>()
              .state;

          final employeesLoaded =
              deliveryEmployeesState.status ==
              ShowDeliveryEmployeesStatus.success;

          final employeesLoading =
              deliveryEmployeesState.status ==
              ShowDeliveryEmployeesStatus.loading;

          final createAssignmentState = context
              .watch<CreateDeliveryAssignmentBloc>()
              .state;

          final isCreating =
              createAssignmentState.status ==
              CreateDeliveryAssignmentStatus.loading;

          return ListView.builder(
            itemCount: state.orders.length,

            itemBuilder: (context, index) {
              final order = state.orders[index];

              Widget? actionWidget;

              // ============================================
              // Pending
              // ============================================

              if (selectedTab == ReceptionistOrderTab.pending) {
                actionWidget = DashboardActionButton(
                  title: 'اطبع QR لبدء العمل',

                  onPressed: () {
                    context.read<PrintQrBloc>().add(
                      PrintQrRequested(
                        orderId: order.id!,
                        serialNumber: order.serialNumber ?? order.id.toString(),
                      ),
                    );
                  },
                );
              }
              // ============================================
              // In Progress
              // ============================================
              else if (selectedTab == ReceptionistOrderTab.inProgress) {
                actionWidget = DashboardActionButton(
                  title: 'تغيير حالة الطلب',

                  onPressed: () async {
                    final bloc = context.read<UpdateOrderStatusBloc>();

                    //------------------------------------------------
                    // LOCK
                    //------------------------------------------------

                    bloc.add(LockOrderRequested(order.id!));

                    final lockState = await bloc.stream.firstWhere(
                      (state) =>
                          state.status == UpdateOrderStatusStatus.locked ||
                          state.status == UpdateOrderStatusStatus.failure,
                    );

                    if (!context.mounted) return;

                    //------------------------------------------------
                    // LOCK FAILED
                    //------------------------------------------------

                    if (lockState.status == UpdateOrderStatusStatus.failure) {
                      AppSnackbarHelper.showFailure(
                        context,
                        title: "خطأ",
                        message:
                            lockState.failure?.message ?? "لا يمكن تعديل الطلب",
                        failure: lockState.failure,
                      );

                      return;
                    }

                    //------------------------------------------------
                    // LOCK SUCCESS
                    //------------------------------------------------

                    await showDialog<bool>(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) {
                        return BlocProvider.value(
                          value: bloc,
                          child: UpdateOrderStatusDialog(
                            orderId: order.id!,
                            onSubmit: (status, notes) {
                              bloc.add(
                                UpdateOrderStatusRequested(
                                  UpdateOrderStatusEntity(
                                    orderId: order.id!,
                                    status: status.apiValue,
                                    notes: notes,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );

                    if (!context.mounted) return;

                    bloc.add(UnlockOrderRequested(order.id!));
                  },
                );
              }
              // ============================================
              // Delivery Assignment
              // ============================================
              else {
                actionWidget = DashboardActionButton(
                  title: isCreating
                      ? 'جاري إنشاء المهمة...'
                      : employeesLoading
                      ? 'جاري تحميل الموظفين...'
                      : dashboardCubit.getButtonTitle(selectedTab),

                  onPressed: (!employeesLoaded || isCreating)
                      ? null
                      : () async {
                          final employees =
                              deliveryEmployeesState.response?.data?.data ?? [];

                          if (employees.isEmpty) {
                            return;
                          }

                          final employeeId = await showDeliveryEmployeeDialog(
                            context,
                            employees,
                          );

                          if (employeeId == null || !context.mounted) {
                            return;
                          }

                          context.read<CreateDeliveryAssignmentBloc>().add(
                            CreateDeliveryAssignmentRequested(
                              CreateDeliveryAssignmentEntity(
                                orderId: order.id!,
                                userId: employeeId,
                              ),
                            ),
                          );
                        },
                );
              }

              final buttonTitle = dashboardCubit.getButtonTitle(selectedTab);

              final showWorkflow = dashboardCubit.shouldUseWorkflow(
                selectedTab,
              );
              return OrderCard(
                order: order,
                actionWidget: actionWidget,
                showWorkflow: showWorkflow,
                buttonTitle: buttonTitle,

                showDetailsButton: true,

                onDetailsPressed: () {
                  ReceptionistOrderDetailsRoute(
                    orderId: order.id!,
                  ).push(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
