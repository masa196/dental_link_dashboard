import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_tasks_model/delivery_tasks_model.dart';

class DeliveryTaskCard extends StatelessWidget {
  const DeliveryTaskCard({super.key, required this.task, this.onLocationTap});

  final TaskInfo task;
  final VoidCallback? onLocationTap;

  @override
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: .3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///================ HEADER =================
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Badge(text: task.direction ?? "TO_LAB"),
                  const Spacer(),

                  _StatusBadge(status: task.status),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 18,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 6),

                  Text(
                    "#${task.orderId}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          Divider(
            height: 1,
            color: scheme.outlineVariant.withValues(alpha: .35),
          ),

          const SizedBox(height: 22),

          ///================ BODY =================
          LayoutBuilder(
            builder: (context, constraints) {
              /// Desktop & Tablet
              if (constraints.maxWidth > 900) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _PersonRow(
                          title: "Delivery Employee",
                          name: task.deliveryUser?.name ?? "-",
                          phone: task.deliveryUser?.phone ?? "-",
                          icon: Icons.local_shipping_outlined,
                        ),
                      ),

                      const SizedBox(width: 18),

                      _VerticalDivider(),

                      const SizedBox(width: 18),

                      Expanded(
                        flex: 3,
                        child: _PersonRow(
                          title: "Doctor",
                          name: task.doctorName ?? "-",
                          phone: task.doctorPhone ?? "-",
                          icon: Icons.person,
                        ),
                      ),

                      const SizedBox(width: 18),

                      _VerticalDivider(),

                      const SizedBox(width: 18),

                      Expanded(
                        flex: 3,
                        child: _LocationBox(
                          location: task.doctorLocation ?? "-",
                          onTap: onLocationTap,
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// Small Width
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _PersonRow(
                          title: "Delivery Employee",
                          name: task.deliveryUser?.name ?? "-",
                          phone: task.deliveryUser?.phone ?? "-",
                          icon: Icons.local_shipping_outlined,
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: _PersonRow(
                          title: "Doctor",
                          name: task.doctorName ?? "-",
                          phone: task.doctorPhone ?? "-",
                          icon: Icons.person,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _LocationBox(
                    location: task.doctorLocation ?? "-",
                    onTap: onLocationTap,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 22),

          Divider(
            height: 1,
            color: scheme.outlineVariant.withValues(alpha: .35),
          ),

          const SizedBox(height: 14),

          ///================ FOOTER =================
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 16,
                color: scheme.onSurfaceVariant,
              ),

              const SizedBox(width: 6),

              Text(
                "Assigned At",
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    task.assignedAt == null
                        ? "-"
                        : DateFormat(
                            "MMM dd, yyyy  •  h:mm a",
                          ).format(task.assignedAt!),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: scheme.primary,
        ),
      ),
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow({
    required this.title,
    required this.name,
    required this.phone,
    required this.icon,
  });

  final String title;
  final String name;
  final String phone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Avatar
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: .08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: scheme.primary),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 14,
                    color: scheme.onSurfaceVariant,
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: Text(
                      phone,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LocationBox extends StatelessWidget {
  const _LocationBox({required this.location, this.onTap});

  final String location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        constraints: const BoxConstraints(minHeight: 86),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.primary),
        ),

        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: .10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: scheme.primary,
                size: 20,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Open Location",
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: scheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: .3),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({this.status});

  final String? status;

  Color _getColor(String? status) {
    switch (status) {
      case "assigned":
        return Colors.blue;
      case "completed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status ?? "-",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
