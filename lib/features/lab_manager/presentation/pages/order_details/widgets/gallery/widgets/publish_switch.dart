import 'package:flutter/material.dart';

class PublishSwitch extends StatelessWidget {
  const PublishSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      contentPadding: EdgeInsets.zero,
      
      subtitle: Text(
        value
            ? "الحالة ستكون منشورة في معرض الأعمال."
            : "سيتم حفظها كمسودة فقط.",
      ),
      onChanged: enabled ? onChanged : null,
    );
  }
}