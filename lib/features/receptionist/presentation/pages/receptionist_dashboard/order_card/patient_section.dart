
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model.dart';
import 'package:flutter/material.dart';


class PatientSection extends StatelessWidget {
  final OrderModel order;

  const PatientSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
        "#${order.id ?? '-'}",
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.2,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          order.patientName?? "No_Name",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 4),

        Text(
           order.doctor.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14,
              color: Colors.grey.shade500,
            ),

            const SizedBox(width: 4),

            Flexible(
              child: Text(
                order.doctor.location,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
