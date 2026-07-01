import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';

class EditEmployeeHeader extends StatelessWidget {
  const EditEmployeeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 8),
        Text(
          isArabic ? 'تعديل الملف الشخصي للموظف' : 'Edit Employee Profile',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}