/*import 'package:flutter/material.dart';

class MaterialIcon extends StatelessWidget {
  const MaterialIcon({
    super.key,
    required this.category,
  });

  final String? category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: scheme.primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        _icon,
        color: scheme.primary,
        size: 26,
      ),
    );
  }

  IconData get _icon {
    switch (category?.toLowerCase()) {
      case "zirconia":
        return Icons.diamond_outlined;

      case "e-max":
        return Icons.auto_awesome;

      case "metal":
        return Icons.precision_manufacturing_outlined;

      case "acrylic":
        return Icons.layers_outlined;

      case "temporary":
        return Icons.science_outlined;

      default:
        return Icons.medical_services_outlined;
    }
  }
}*/