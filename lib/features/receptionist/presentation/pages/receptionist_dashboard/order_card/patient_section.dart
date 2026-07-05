// ignore_for_file: non_constant_identifier_names


import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';
import 'package:flutter/material.dart';

class PatientSection extends StatelessWidget {
  final OrderModel order;

  const PatientSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 260;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //------------------------------------------------
            // TOP ROW (Serial + Type)
            //------------------------------------------------
           isCompact
    ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SerialText(order.serialNumber),
          const SizedBox(height: 6),
          _PriorityPill(order: order),
        ],
      )
    : Row(
        children: [
          Expanded(child: _SerialText(order.serialNumber)),
          const SizedBox(width: 10),
          _PriorityPill(order: order),
        ],
      ),

            const SizedBox(height: 6),

            //------------------------------------------------
            // PATIENT NAME
            //------------------------------------------------
            Text(
              order.patientName ?? "No Name",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 4),

            //------------------------------------------------
            // DOCTOR NAME
            //------------------------------------------------
            Text(
              "Dr. ${order.doctor.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            //------------------------------------------------
            // LOCATION (RESPONSIVE SAFE)
            //------------------------------------------------
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.doctor.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  //------------------------------------------------------
  // Extracted Widgets (clean + reusable)
  //------------------------------------------------------

  Widget _SerialText(String? value) {
    return Text(
      value ?? "No Serial",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 13,
        letterSpacing: 1.2,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w800,
      ),
    );
  }

}



Widget _PriorityPill({required OrderModel order}) {
  final isUrgent = order.priority == "urgent";

  final color = isUrgent
      ? const Color(0xFFEF4444)
      : const Color(0xFF3B82F6);

  final background = isUrgent
      ? const Color(0xFFFEE2E2)
      : const Color(0xFFE0F2FE);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Text(
      isUrgent ? "مستعجل" : "عادي",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    ),
  );
}