import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/cubit/manage_employee/create_employee/create_employee_form_state.dart';
import 'package:dental_link_dashboard/shared/widgets/app_text_field.dart';

import 'create_employee_section_card.dart';

class CreateEmployeeContactSection extends StatelessWidget {
  const CreateEmployeeContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;

    return CreateEmployeeSectionCard(
      title: isArabic ? 'معلومات التواصل' : 'Contact information',
      icon: Icons.contact_mail_outlined,
      children: [
        BlocBuilder<CreateEmployeeFormCubit, CreateEmployeeFormState>(
          builder: (context, formState) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 680;

                final emailField = AppTextField(
                  initialValue: formState.email,
                  labelText: isArabic ? 'البريد الإلكتروني' : 'Email',
                  hint: 'name@example.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  errorText: formState.emailError,
                  onTap: () =>
                      context.read<CreateEmployeeFormCubit>().clearEmailError(),
                  onChanged: context
                      .read<CreateEmployeeFormCubit>()
                      .updateEmail,
                );

                final phoneField = AppTextField(
                  initialValue: formState.phone,
                  labelText: isArabic ? 'رقم الهاتف' : 'Phone number',
                  hint: isArabic ? 'أدخل رقم الهاتف' : 'Enter phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  errorText: formState.phoneError,
                  onTap: () =>
                      context.read<CreateEmployeeFormCubit>().clearPhoneError(),
                  onChanged: context
                      .read<CreateEmployeeFormCubit>()
                      .updatePhone,
                );

                if (isCompact) {
                  return Column(
                    children: [
                      emailField,
                      const SizedBox(height: AppSpacing.md),
                      phoneField,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: emailField),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: phoneField),
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
