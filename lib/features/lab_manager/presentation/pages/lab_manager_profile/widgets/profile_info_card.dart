import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/profile_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/lab_manager_profile/widgets/profile_info_field.dart';

import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard._({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;


  factory ProfileInfoCard.contact({
    required UserInProfile user,
  }) {
    return ProfileInfoCard._(
      title: 'معلومات الاتصال',
      icon: Icons.contact_phone_outlined,

      children: [
        ProfileInfoField(
          icon: Icons.phone_outlined,
          label: 'رقم الهاتف',
          value: user.phone ?? '-',
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        ProfileInfoField(
          icon: Icons.email_outlined,
          label: 'البريد الإلكتروني',
          value: user.email ?? '-',
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

    /*    ProfileInfoField(
          icon: Icons.location_on_outlined,
          label: 'الموقع',
          value: user.location?.toString() ?? '-',
        ),*/
      ],
    );
  }


  factory ProfileInfoCard.personal({
    required UserInProfile user,
  }) {
    return ProfileInfoCard._(
      title: 'المعلومات الشخصية',
      icon: Icons.person_outline,

      children: [

        ProfileInfoField(
          icon: Icons.badge_outlined,
          label: 'الاسم الكامل',
          value: user.name ?? '-',
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),
     
     /*
        ProfileInfoField(
          icon: Icons.calendar_month_outlined,
          label: 'تاريخ الميلاد',
          value: user.birthdate?.toString() ?? '-',
        ),
*/
        const SizedBox(
          height: AppSpacing.md,
        ),

        ProfileInfoField(
          icon: Icons.event_available_outlined,
          label: 'تاريخ الانضمام',
          value: _formatDate(user.joinedAt),
        ),
      ],
    );
  }


  static String _formatDate(DateTime? date) {
    if (date == null) return '-';

    return '${date.day}/${date.month}/${date.year}';
  }


  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      title: title,
      icon: icon,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,

        children: children,
      ),
    );
  }
}