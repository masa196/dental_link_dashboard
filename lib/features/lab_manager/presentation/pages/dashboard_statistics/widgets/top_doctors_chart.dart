import 'dart:math' as math;

import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/dashboard_statistics/dashboard_statistics_model.dart';
import 'package:flutter/material.dart';

class TopDoctorsChart extends StatelessWidget {
  const TopDoctorsChart({
    super.key,
    required this.statistics,
  });

  final TopClinicsStatistics? statistics;

  @override
  Widget build(BuildContext context) {
    final doctors = [
      ...(statistics?.doctors ?? []),
    ];

    if (doctors.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد بيانات للأطباء',
        ),
      );
    }

    doctors.sort(
      (a, b) => (b.ordersCount ?? 0)
          .compareTo(a.ordersCount ?? 0),
    );

    final maxOrders = doctors.fold<int>(
      0,
      (previous, doctor) => math.max(
        previous,
        doctor.ordersCount ?? 0,
      ),
    );

    return ListView.separated(
      itemCount: doctors.length,
      physics:
          const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (_, __) =>
          const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        final orders =
            doctor.ordersCount ?? 0;

        final ratio = maxOrders == 0
            ? 0.0
            : orders / maxOrders;

        return Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                doctor.name ?? '-',
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      AppLightColors.onSurface,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Align(
                alignment:
                    Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(
                    height: 13,
                    decoration:
                        BoxDecoration(
                      color:
                          AppLightColors.success,
                      borderRadius:
                          BorderRadius.circular(
                        4,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            SizedBox(
              width: 30,
              child: Text(
                orders.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      AppLightColors.hint,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}