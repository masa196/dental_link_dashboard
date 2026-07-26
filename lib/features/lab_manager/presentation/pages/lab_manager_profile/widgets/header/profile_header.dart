import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/lab_manager_profile/lab_manager_profile_model.dart';

import 'package:flutter/material.dart';

import 'info_chip.dart';
import 'profile_avatar.dart';



class ProfileHeader extends StatelessWidget {

  const ProfileHeader({
    super.key,
    required this.user,
    required this.roles,
  });

  final UserInProfile user;
  final List<String> roles;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final isMobile = MediaQuery.of(context).size.width < 700;

    if(isMobile){
      return Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment:  isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: ProfileAvatar(
              image:user.profileImage,
            ),
          ),
          const SizedBox(
            height:AppSpacing.lg,
          ),
          _HeaderDetails(
            user:user,
            roles:roles,
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Row(
          children:[
            ProfileAvatar(
              image:user.profileImage,
            ),
            const SizedBox(
              width:AppSpacing.lg,
            ),
            _HeaderDetails(
              user:user,
              roles:roles,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeaderDetails extends StatelessWidget {

  const _HeaderDetails({
    required this.user,
    required this.roles,
  });

  final UserInProfile user;
  final List<String> roles;

  @override
  Widget build(BuildContext context) {

    final scheme = context.scheme;
    final isArabic = context.isArabic;

    return Column(
      crossAxisAlignment:isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children:[
        InfoChip(
          text:
          roles.isNotEmpty
          ? roles.first
          : (
            isArabic
            ? 'مدير المخبر'
            : 'Lab Manager'
          ),
        ),
        const SizedBox(
          height:AppSpacing.sm,
        ),
        Text(
          user.name ?? '-',
          style:TextStyle(
            fontSize:  AppTypography.fs32,
            fontWeight:
            FontWeight.w800,
            height:1.1,
            color: scheme.primary,
          ),
        ),
        const SizedBox(
          height:AppSpacing.sm,
        ),
      ],
    );
  }
}