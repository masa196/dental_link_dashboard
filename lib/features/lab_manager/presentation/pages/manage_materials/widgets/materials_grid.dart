import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/material_card.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_mode.dart';

import 'package:flutter/material.dart';

class MaterialsGrid extends StatelessWidget {
  const MaterialsGrid({
    super.key,
    required this.materials,
    required this.mode,

    this.onEdit,
    this.onDelete,
  });

  final List<MaterialItem> materials;

  final MaterialsMode mode;

  final ValueChanged<MaterialItem>? onEdit;

  final ValueChanged<MaterialItem>? onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final columns = _columns(constraints.maxWidth);

        return GridView.builder(
          shrinkWrap: true,

          physics: const NeverScrollableScrollPhysics(),

          itemCount: materials.length,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,

            crossAxisSpacing: 24,

            mainAxisSpacing: 24,

            childAspectRatio: mode.canEdit ? .95 : 1.1,
          ),

          itemBuilder: (_, index) {
            final material = materials[index];

            return MaterialCard(
              material: material,
              mode: mode,
              onEdit: () {
                onEdit?.call(material);
              },
              onDelete: () {
                onDelete?.call(material);
              },
            );
          },
        );
      },
    );
  }

  int _columns(double width) {
    if (width >= 1200) return 4;

    if (width >= 1100) return 3;

    if (width >= 600) return 2;

    return 1;
  }
}
