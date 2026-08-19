import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/system_logs/system_logs_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/system_logs/system_logs_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/system_logs/system_logs_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/system_logs/widgets/system_logs_list.dart';
import 'package:dental_link_dashboard/shared/dashboard_header/dashboard_header.dart';
import 'package:dental_link_dashboard/shared/pagination/floating_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemLogsView extends StatelessWidget {
  const SystemLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return BlocBuilder<SystemLogsBloc, SystemLogsState>(
      builder: (context, state) {
        if (state.isLoading && state.data.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.isFailure && state.data.isEmpty) {
          return Center(
            child: Text(
              state.error?.message ??
                  'حدث خطأ أثناء جلب سجل عمليات النظام',
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallHeight = constraints.maxHeight < 350;

            final content = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SystemLogsList(
                    logs: state.data,
                  ),

                  if (state.isLoading) ...[
                    const SizedBox(height: 20),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],

                  // Pagination
                  if (!isSmallHeight && state.lastPage > 1) ...[
                    const SizedBox(height: 28),

                    IgnorePointer(
                      ignoring: state.isLoading,
                      child: FloatingPagination(
                        currentPage: state.currentPage,
                        totalPages: state.lastPage,
                        onPageChanged: (page) {
                          context.read<SystemLogsBloc>().add(
                                ChangeSystemLogsPageEvent(
                                  page: page,
                                ),
                              );
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 30),
                ],
              ),
            );

            // ارتفاع صغير جدًا:
            // نخفي Pagination بالكامل.
            if (isSmallHeight) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashboardHeader(
                      title: isArabic
                          ? 'سجل عمليات النظام'
                          : 'System Logs',
                      showMenuButton: !Responsive.isDesktop(context),
                      showNotification: false,
                      showSearchBar: false,
                    ),

                    const SizedBox(height: 20),

                    content,
                  ],
                ),
              );
            }

            return Column(
              children: [
                DashboardHeader(
                  title: isArabic
                      ? 'سجل عمليات النظام'
                      : 'System Logs',
                  showMenuButton: !Responsive.isDesktop(context),
                  showNotification: false,
                  showSearchBar: false,
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: content,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}