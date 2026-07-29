import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctor_actions.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctor_progress_bar.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    this.onDetailsTap,
  });

  final DoctorModel doctor;
  final VoidCallback? onDetailsTap;

  double get paymentPercentage {
    final billed = doctor.totalBilled ?? 0;
    final paid = doctor.totalPaid ?? 0;

    if (billed == 0) return 0;

    return (paid / billed).clamp(0, 1);
  }

  Color _statusColor(ColorScheme scheme) {
    final percentage = paymentPercentage * 100;

    if (percentage < 40) {
      return scheme.error;
    }
    if (percentage < 70) {
      return scheme.secondary;
    }
    return scheme.primary;
  }

  String _formatMoney(int? value) {
    return (value ?? 0).toString();
  }
  @override
  Widget build(BuildContext context) {

    final scheme = Theme.of(context).colorScheme;
    final statusColor = _statusColor(scheme);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0,4),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Padding(
           padding: const EdgeInsets.all(16),

            child: Column(  crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// Doctor Information
                
                Text(
                  doctor.name ?? "-",
                  maxLines: 1,
                  overflow:TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [

                    Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color:
                          scheme.onSurface
                              .withValues(alpha:0.55),
                    ),

                    const SizedBox(width:6),

                    Expanded(
                      child: Text(
                        doctor.phone ?? "-",

                        maxLines:1,

                        overflow:
                            TextOverflow.ellipsis,

                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color:
                                  scheme.onSurface
                                      .withValues(
                                        alpha:0.65,
                                      ),
                            ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height:28),

                /// Payment Progress

                DoctorProgressBar(
                  totalPaid:
                      doctor.totalPaid ?? 0,

                  totalBilled:
                      doctor.totalBilled ?? 0,
                ),

                const SizedBox(height:24),

                Divider(
                  color:
                      scheme.outlineVariant,
                ),

                const SizedBox(height:12),

                Text(
                  "المبلغ المتبقي",

                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color:
                            scheme.onSurface
                                .withValues(
                                  alpha:0.55,
                                ),
                      ),
                ),


                const SizedBox(height:6),

                Text(
                  _formatMoney(
                    doctor.totalOwed,
                  ),

                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight:
                            FontWeight.w900,

                        color:
                            statusColor,
                      ),
                ),
              ],
            ),
          ),

          /// Footer
          DoctorActions(
            onDetails:
                onDetailsTap ??
                () {},
          ),

        ],
      ),
    );
  }
}