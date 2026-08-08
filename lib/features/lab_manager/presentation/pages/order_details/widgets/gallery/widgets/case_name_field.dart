import 'package:flutter/material.dart';

class CaseNameField extends StatelessWidget {
  const CaseNameField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: const InputDecoration(
        labelText: "اسم الحالة",
        border: OutlineInputBorder(),
      ),
    );
  }
}