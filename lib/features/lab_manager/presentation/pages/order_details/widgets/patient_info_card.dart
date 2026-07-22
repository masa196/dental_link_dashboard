// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';

class PatientInfoCard extends StatelessWidget {
  const PatientInfoCard({super.key, required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _Header(order: order),

          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                _InfoRow(title: "عنوان الحالة", value: order.caseType ?? "-"),
                _Divider(),

                _InfoRow(title: "اسم المريض", value: order.patientName ?? "-"),
                _Divider(),

                _InfoRow(title: "الطبيب", value: order.doctor?.name ?? "-"),
                _Divider(),

                _InfoRow(title: "المخبر", value: order.lab?.name ?? "-"),
                _Divider(),

                _InfoRow(
                  title: "الموقع",
                  value: order.lab?.address ?? "-",
                  isLocation: true,
                ),
                _Divider(),

                _PriceRow(order: order),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      color: scheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.white),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "معلومات الحالة والمريض",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "#${order.serialNumber ?? order.id}",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isLocation;

  const _InfoRow({
    required this.title,
    required this.value,
    this.isLocation = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
            ),
          ),
          if (isLocation)
            Icon(Icons.location_on, size: 16, color: scheme.primary),
          if (isLocation) const SizedBox(width: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: Theme.of(context).colorScheme.outline);
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.order});

  final OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "التكلفة الإجمالية",
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: scheme.primary.withOpacity(.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              order.price != null ? " ${order.price}  SYP " : "-",
              style: TextStyle(
                color: scheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
