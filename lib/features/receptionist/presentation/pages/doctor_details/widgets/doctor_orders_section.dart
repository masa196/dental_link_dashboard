import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/doctors_page.dart';
import 'package:flutter/material.dart';

class DoctorOrdersSection extends StatelessWidget {
  const DoctorOrdersSection({
    super.key,
    required this.orders,
    required this.paymentStatus,
    required this.onPaymentStatusChanged,
    this.pagination,
    this.onPageChanged,
    required this.doctorId,
    required this.mode,
  });

  final List<OrderInDoc> orders;
  final int doctorId;
  final DoctorsPageMode mode;

  /// paid / unpaid
  final String paymentStatus;
  final ValueChanged<String> onPaymentStatusChanged;
  final Pagination? pagination;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          _OrdersTabs(
            selectedStatus: paymentStatus,
            onChanged: onPaymentStatusChanged,
          ),
          _OrdersTable(orders: orders, doctorId: doctorId, mode: mode),

          Divider(
            thickness: 1,
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          _Pagination(pagination: pagination, onPageChanged: onPageChanged),
        ],
      ),
    );
  }
}

class _OrdersTabs extends StatelessWidget {
  const _OrdersTabs({required this.selectedStatus, required this.onChanged});

  final String selectedStatus;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          _TabItem(
            title: 'الطلبات المدفوعة',
            active: selectedStatus == 'paid',
            onTap: () => onChanged('paid'),
          ),
          _TabItem(
            title: 'الطلبات غير المدفوعة',
            active: selectedStatus == 'unpaid',
            onTap: () => onChanged('unpaid'),
          ),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, size: 18),
            label: const Text('تصفية سريعة'),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.title,
    required this.active,
    required this.onTap,
  });

  final String title;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

class _OrdersTable extends StatelessWidget {
  const _OrdersTable({required this.orders, required this.doctorId, required this.mode});
  final List<OrderInDoc> orders;
  final int doctorId;
  final DoctorsPageMode mode;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              headingRowHeight: 56,

              dataRowMinHeight: 60,

              dataRowMaxHeight: 60,

              headingTextStyle: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),

              columnSpacing: 80,

              horizontalMargin: 28,

              dividerThickness: .5,
              columns: const [
                DataColumn(label: Text('رقم الطلب')),
                DataColumn(label: Text('نوع الإجراء')),
                DataColumn(label: Text('الحالة')),
                DataColumn(label: Text('التاريخ')),
                DataColumn(label: Text('التكلفة')),
                DataColumn(label: Text('الإجراء')),
              ],

              rows: List.generate(orders.length, (index) {
                final order = orders[index];

                return DataRow(
                  mouseCursor: const WidgetStatePropertyAll(
                    SystemMouseCursors.click,
                  ),

                  color: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: .08);
                    }

                    return index.isEven
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: .03);
                  }),
                  cells: [
                    DataCell(Text(order.serialNumber ?? '-')),

                    DataCell(
                      Text(
                        order.caseType ?? '-',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),

                    DataCell(_OrderStatusChip(status: order.status)),

                    DataCell(Text(_formatDate(order.date))),

                    DataCell(
                      Text(
                        order.cost ?? '-',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    DataCell(
                      OutlinedButton(
                        onPressed: () {
                          if (mode == DoctorsPageMode.labManager) {
                            DoctorOrderDetailsRoute(
                              doctorId: doctorId,
                              orderId: order.id!,
                            ).go(context);
                          } else {
                            ReceptionistDoctorOrderDetailsRoute(
                              doctorId: doctorId,
                              orderId: order.id!,
                            ).go(context);
                          }
                        },
                        child: const Text('التفاصيل'),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _OrderStatusChip extends StatelessWidget {
  const _OrderStatusChip({required this.status});
  final String? status;

  @override
  Widget build(BuildContext context) {
    final data = _statusData(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),

      decoration: BoxDecoration(
        color: data.background,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),

      child: Text(
        data.label,

        style: TextStyle(
          color: data.color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

_StatusInfo _statusData(BuildContext context, String? status) {
  final scheme = Theme.of(context).colorScheme;
  switch (status) {
    case 'new':
      return _StatusInfo(
        'جديدة',
        scheme.primary,
        scheme.primary.withValues(alpha: 0.12),
      );
    case 'pending':
      return _StatusInfo(
        'قيد الانتظار',
        Colors.orange,
        Colors.orange.withValues(alpha: 0.12),
      );
    case 'in_progress':
      return _StatusInfo(
        'قيد التنفيذ',
        scheme.primary,
        scheme.primary.withValues(alpha: 0.12),
      );
    case 'resend_wrong_impression':
      return _StatusInfo(
        'إعادة الطبعة',
        scheme.error,
        scheme.error.withValues(alpha: 0.12),
      );
    case 'try_on':
      return _StatusInfo(
        'تجربة',
        Colors.deepPurple,
        Colors.deepPurple.withValues(alpha: 0.12),
      );
    case 'completed':
      return _StatusInfo(
        'مكتملة',
        Colors.green,
        Colors.green.withValues(alpha: 0.12),
      );
    default:
      return _StatusInfo(
        status ?? '-',
        scheme.onSurface,
        scheme.surfaceContainerHighest,
      );
  }
}

class _StatusInfo {
  const _StatusInfo(this.label, this.color, this.background);
  final String label;
  final Color color;
  final Color background;
}

class _Pagination extends StatelessWidget {
  const _Pagination({required this.pagination, this.onPageChanged});

  final Pagination? pagination;
  final ValueChanged<int>? onPageChanged;

  List<dynamic> _buildPages(int current, int last) {
    if (last <= 5) {
      return List.generate(last, (index) => index + 1);
    }

    final pages = <dynamic>[1];

    if (current > 3) {
      pages.add('...');
    }

    final start = (current - 1).clamp(2, last - 1);
    final end = (current + 1).clamp(2, last - 1);

    for (int i = start; i <= end; i++) {
      if (!pages.contains(i)) {
        pages.add(i);
      }
    }

    if (current < last - 2) {
      pages.add('...');
    }

    if (!pages.contains(last)) {
      pages.add(last);
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    if (pagination == null) {
      return const SizedBox();
    }

    final currentPage = pagination!.currentPage ?? 1;
    final lastPage = pagination!.lastPage ?? 1;

    final pages = _buildPages(currentPage, lastPage);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'عرض ${pagination!.to ?? 0} من إجمالي ${pagination!.total ?? 0} طلب',
          ),
          Row(
            children: [
              IconButton(
                onPressed: currentPage > 1
                    ? () => onPageChanged?.call(currentPage - 1)
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),

              ...pages.map((page) {
                if (page == '...') {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                    child: Text('...'),
                  );
                }

                final pageNumber = page as int;
                final selected = pageNumber == currentPage;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    onTap: () => onPageChanged?.call(pageNumber),
                    child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Text(
                        '$pageNumber',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              IconButton(
                onPressed: currentPage < lastPage
                    ? () => onPageChanged?.call(currentPage + 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime? date) {
  if (date == null) {
    return '-';
  }
  return '${date.day}/${date.month}/${date.year}';
}
