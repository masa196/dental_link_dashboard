import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/auth/user_role_cubit.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';

/// صفحة لوحة التحكم الافتراضية لمدير المخبر
class LabManagerDashboard extends StatelessWidget {
  const LabManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final scheme = context.scheme;
    final isArabic = context.isArabic;

    return BlocBuilder<UserRoleCubit, UserRoleState>(
      builder: (context, userRoleState) {
        final userName = userRoleState.userName ?? 'مستخدم';

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.md : AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// رسالة الترحيب
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: isArabic ? 'مرحبا ' : 'Welcome, ',
                      style: TextStyle(
                        fontSize: AppTypography.fs32,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: userName,
                      style: TextStyle(
                        fontSize: AppTypography.fs32,
                        fontWeight: FontWeight.bold,
                        color: scheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                isArabic ? 'لوحة تحكم مدير المخبر' : 'Lab Manager Dashboard',
                style: TextStyle(
                  fontSize: AppTypography.fs16,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              /// بطاقات المعلومات
              GridView.count(
                crossAxisCount: isMobile ? 1 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: AppSpacing.lg,
                mainAxisSpacing: AppSpacing.lg,
                children: [
                  _DashboardCard(
                    title: isArabic ? 'الاختبارات القادمة' : 'Upcoming Tests',
                    icon: Icons.calendar_today_outlined,
                    count: '12',
                    scheme: scheme,
                  ),
                  _DashboardCard(
                    title: isArabic ? 'المرضى اليوم' : 'Patients Today',
                    icon: Icons.people_outline,
                    count: '28',
                    scheme: scheme,
                  ),
                  _DashboardCard(
                    title: isArabic ? 'التقارير المنتظرة' : 'Pending Reports',
                    icon: Icons.assessment_outlined,
                    count: '5',
                    scheme: scheme,
                  ),
                  _DashboardCard(
                    title: isArabic ? 'الموظفون' : 'Staff Members',
                    icon: Icons.person_outline,
                    count: '8',
                    scheme: scheme,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// بطاقة معلومات للوحة التحكم
class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String count;
  final ColorScheme scheme;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.count,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: scheme.primary, size: 32),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    count,
                    style: TextStyle(
                      fontSize: AppTypography.fs24,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: TextStyle(
                fontSize: AppTypography.fs14,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
