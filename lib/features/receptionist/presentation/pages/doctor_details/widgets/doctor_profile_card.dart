import 'package:dental_link_dashboard/core/constants/app_colors/app_dark_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';
import 'package:flutter/material.dart';

class DoctorProfileCard extends StatelessWidget {
  const DoctorProfileCard({
    super.key,
    required this.doctor,
    this.doctorSummary,
  });

  final DoctorInDetails doctor;
  final DoctorModel? doctorSummary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,

        borderRadius: BorderRadius.circular(AppRadius.xl),

        boxShadow: [
          BoxShadow(
            blurRadius: 8,

            offset: const Offset(0, 3),

            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.05),
          ),
        ],
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              _DoctorInfo(doctor: doctor),

              if (!isMobile) const SizedBox(width: AppSpacing.xl),

              if (isMobile) const SizedBox(height: AppSpacing.xl),

              _DoctorStatistics(doctorSummary: doctorSummary),
            ],
          );
        },
      ),
    );
  }
}

class _DoctorInfo extends StatelessWidget {
  const _DoctorInfo({required this.doctor});

  final DoctorInDetails doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 48,

              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? AppLightColors.avatarBackground
                  : AppDarkColors.avatarBackground,

              backgroundImage: doctor.profileImage != null
                  ? NetworkImage(doctor.profileImage)
                  : null,

              child: doctor.profileImage == null
                  ? Icon(
                      Icons.person,

                      size: 45,

                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    )
                  : null,
            ),

            Positioned(
              bottom: 2,

              right: 2,

              child: Container(
                width: 18,

                height: 18,

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,

                  shape: BoxShape.circle,

                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,

                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: AppSpacing.lg),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              doctor.name ?? '-',

              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: AppSpacing.xs),

            Text(
              doctor.email ?? '-',

              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppLightColors.textSecondary
                    : AppDarkColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.xs),

            Text(
              doctor.phone ?? '-',

              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppLightColors.textSecondary
                    : AppDarkColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DoctorStatistics extends StatelessWidget {
  const _DoctorStatistics({required this.doctorSummary});

  final DoctorModel? doctorSummary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),

      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppLightColors.statisticsBackground
            : AppDarkColors.statisticsBackground,

        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          _StatisticItem(
            title: 'إجمالي الطلبات',
            value: '${doctorSummary?.ordersCount ?? 0}',
          ),

          const _Divider(),

          _StatisticItem(
            title: 'إجمالي المدفوعات',
            value: '${doctorSummary?.totalPaid ?? 0}',
          ),

          const _Divider(),

          _StatisticItem(
            title: 'المبلغ المتبقي',
            value: '${doctorSummary?.totalOwed ?? 0}',
            isDanger: true,
          ),
        ],
      ),
    );
  }
}

class _StatisticItem extends StatelessWidget {
  const _StatisticItem({
    required this.title,

    required this.value,

    this.isDanger = false,
  });

  final String title;

  final String value;

  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),

      child: Column(
        children: [
          Text(
            title,

            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppLightColors.textSecondary
                  : AppDarkColors.textSecondary,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            value,

            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isDanger
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,

      width: 1,

      color: Theme.of(context).dividerColor,
    );
  }
}
