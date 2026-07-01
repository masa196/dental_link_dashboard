import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/update_employee/update_employee_form_state.dart';
import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';
import 'edit_employee_section_card.dart';

class EditEmployeeSecuritySection extends StatefulWidget {
  const EditEmployeeSecuritySection({super.key});

  @override
  State<EditEmployeeSecuritySection> createState() => _EditEmployeeSecuritySectionState();
}

class _EditEmployeeSecuritySectionState extends State<EditEmployeeSecuritySection> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  @override
  void initState() {
    super.initState();
    // نترك الحقول فارغة بشكل احترافي، والـ hint يؤدي الغرض التوضيحي للـ UX
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return EditEmployeeSectionCard(
      title: isArabic ? 'الأمان والحماية' : 'Security',
      icon: Icons.lock_outline,
      children: [
        BlocBuilder<UpdateEmployeeFormCubit, UpdateEmployeeFormState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 680;

                final passwordField = AppTextField(
                  controller: _passwordController,
                  labelText: isArabic ? 'كلمة المرور الجديدة' : 'New password',
                  hint: isArabic ? 'اتركها فارغة للاحتفاظ بكلمة المرور القديمة' : 'Leave blank to keep current password',
                  icon: Icons.lock_outline,
                  obscureText: !state.isPasswordVisible,
                  errorText: state.passwordError,
                  onTap: () => context.read<UpdateEmployeeFormCubit>().clearPasswordError(),
                  onChanged: context.read<UpdateEmployeeFormCubit>().updatePassword,
                  suffixIcon: IconButton(
                    onPressed: () => context.read<UpdateEmployeeFormCubit>().togglePasswordVisibility(),
                    icon: Icon(state.isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  ),
                );

                final confirmationField = AppTextField(
                  controller: _confirmController,
                  labelText: isArabic ? 'تأكيد كلمة المرور' : 'Confirm password',
                  hint: isArabic ? 'أعد كتابة كلمة المرور الجديدة' : 'Re-enter new password',
                  icon: Icons.lock_reset_outlined,
                  obscureText: !state.isConfirmPasswordVisible,
                  errorText: state.confirmPasswordError,
                  onTap: () => context.read<UpdateEmployeeFormCubit>().clearConfirmPasswordError(),
                  onChanged: context.read<UpdateEmployeeFormCubit>().updateConfirmPassword,
                  suffixIcon: IconButton(
                    onPressed: () => context.read<UpdateEmployeeFormCubit>().toggleConfirmPasswordVisibility(),
                    icon: Icon(state.isConfirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  ),
                );

                if (isCompact) {
                  return Column(
                    children: [
                      passwordField,
                      const SizedBox(height: AppSpacing.md),
                      confirmationField,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: passwordField),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: confirmationField),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}