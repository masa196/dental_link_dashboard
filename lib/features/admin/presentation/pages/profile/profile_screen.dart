import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/profile/profile_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenu;

  const ProfileScreen({super.key, this.onMenuTap, this.showMenu = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return BlocProvider(
      create: (_) => locator<ProfileCubit>(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Directionality(
            textDirection: context.isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Column(
              children: [
                _TopBar(onMenuTap: onMenuTap, showMenu: showMenu),
                Divider(color: Theme.of(context).dividerColor),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1180),
                          child: SingleChildScrollView(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              isMobile ? AppSpacing.lg : 56,
                              isMobile ? AppSpacing.lg : 34,
                              isMobile ? AppSpacing.lg : 56,
                              AppSpacing.xl,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    constraints.maxHeight -
                                    (isMobile ? AppSpacing.lg : 34) -
                                    AppSpacing.xl,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _ProfileHeader(
                                    isArabic: context.isArabic,
                                    isMobile: isMobile,
                                  ),
                                  SizedBox(
                                    height: isMobile ? AppSpacing.lg : 44,
                                  ),
                                  isMobile
                                      ? const Column(
                                          children: [
                                            _SecurityCard(),
                                            SizedBox(height: AppSpacing.lg),
                                            _PersonalInfoCard(),
                                          ],
                                        )
                                      : const Row(
                                          children: [
                                            Expanded(child: _SecurityCard()),
                                            SizedBox(width: AppSpacing.lg),
                                            Expanded(
                                              child: _PersonalInfoCard(),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenu;
  const _TopBar({this.onMenuTap, this.showMenu = false});

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isArabic = context.isArabic;

    return Container(
      height: 30,
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: [
          if (showMenu)
            IconButton(icon: const Icon(Icons.menu), onPressed: onMenuTap),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: isArabic ? "لوحة مدير النظام" : "Admin Dashboard",
                    style: TextStyle(
                      fontSize: AppTypography.fs14,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  TextSpan(
                    text: " / ",
                    style: TextStyle(
                      fontSize: AppTypography.fs14,
                      color: scheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  TextSpan(
                    text: isArabic ? "الملف الشخصي" : "Profile",
                    style: TextStyle(
                      fontSize: AppTypography.fs14,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.isArabic, required this.isMobile});

  final bool isArabic;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: _ProfileAvatar(scheme: scheme),
          ),
          const SizedBox(height: AppSpacing.lg),
          _HeaderDetails(isArabic: isArabic),
          const SizedBox(height: AppSpacing.lg),
          const Align(
            alignment: Alignment.centerLeft,
            child: _ProfileActionButton(),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProfileAvatar(scheme: scheme),
            const SizedBox(width: AppSpacing.lg),
            _HeaderDetails(isArabic: isArabic),
          ],
        ),
        const _ProfileActionButton(),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.14),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 56,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
        ),
        PositionedDirectional(
          bottom: 2,
          end: 2,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: scheme.shadow.withValues(alpha: 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 15,
              color: scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderDetails extends StatelessWidget {
  const _HeaderDetails({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final crossAxisAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final textAlign = isArabic ? TextAlign.right : TextAlign.left;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        _InfoChip(
          text: isArabic ? 'مدير النظام' : 'System Admin',
          backgroundColor: const Color(0xFFF0F3C2),
          textColor: const Color(0xFF7A7F20),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          ' أحمد المنصوري',
          textAlign: textAlign,
          style: TextStyle(
            fontSize: AppTypography.fs32,
            height: 1.05,
            fontWeight: FontWeight.w800,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton();

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return SizedBox(
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined, size: 18),
        label: const Text('تعديل الملف الشخصي'),
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: AppLightColors.background,
          elevation: 10,
          shadowColor: scheme.primary.withValues(alpha: 0.28),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          textStyle: TextStyle(
            fontSize: AppTypography.fs14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppTypography.fs12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard();

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      title: 'الاتصال والأمان',
      icon: Icons.shield_outlined,
      children: const [
        _Field(
          label: 'رقم الهاتف',
          value: '+971 50 123 4567',
          fieldKey: 'phone',
          icon: Icons.phone_iphone,
        ),
        _Field(
          label: 'البريد الإلكتروني',
          value: 'a.almansouri@labos.clinical.ae',
          fieldKey: 'email',
          icon: Icons.alternate_email,
        ),
        _Field(
          label: 'كلمة السر',
          value: '••••••••••',
          fieldKey: 'password',
          icon: Icons.lock_outline,
          trailingIcon: Icons.visibility_outlined,
        ),
      ],
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  const _PersonalInfoCard();

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      title: 'المعلومات الشخصية',
      icon: Icons.person_outline,
      children: const [
        _Field(
          label: 'الاسم الكامل',
          value: 'أحمد محمد المنصوري',
          fieldKey: 'name',
          icon: Icons.badge_outlined,
        ),
        _Field(
          label: 'تاريخ الميلاد',
          value: '12 مايو 1985',
          fieldKey: 'birthDate',
          icon: Icons.calendar_month_outlined,
        ),
        _Field(
          label: 'تاريخ الانضمام',
          value: '01 يناير 2020',
          fieldKey: 'joinDate',
          icon: Icons.event_available_outlined,
        ),
      ],
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: scheme.primary, size: 18),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppTypography.fs18,
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.value,
    required this.fieldKey,
    this.icon,
    this.trailingIcon,
  });

  final String label;
  final String value;
  final String fieldKey;
  final IconData? icon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boxColor = isDark ? const Color(0xFF3A3D41) : const Color(0xFFF2F2F2);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              color: scheme.onSurface.withValues(alpha: 0.72),
              fontSize: AppTypography.fs12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: AppSpacing.sm),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final isFocused = state.focusedField == fieldKey;

              return TextFormField(
                textAlign: TextAlign.center,
                onTap: () => context.read<ProfileCubit>().focusField(fieldKey),
                onTapOutside: (_) =>
                    context.read<ProfileCubit>().focusField(null),
                onChanged: (value) {
                  context.read<ProfileCubit>().updateField(fieldKey, value);
                  context.read<ProfileCubit>().focusField(fieldKey);
                },
                style: TextStyle(
                  fontSize: AppTypography.fs14,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: boxColor,
                  hintText: value,
                  hintStyle: TextStyle(
                    fontSize: AppTypography.fs14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withValues(alpha: 0.35),
                  ),
                  prefixIcon: icon == null
                      ? null
                      : Icon(icon, size: 16, color: scheme.primary),
                  suffixIcon: trailingIcon == null
                      ? null
                      : Icon(trailingIcon, size: 16, color: scheme.primary),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    borderSide: BorderSide(
                      color: isFocused ? scheme.primary : Colors.transparent,
                      width: isFocused ? 2.5 : 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    borderSide: BorderSide(color: scheme.primary, width: 2.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
