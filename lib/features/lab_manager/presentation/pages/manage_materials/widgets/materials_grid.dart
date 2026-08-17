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

        const cardWidth = 280.0;
        const spacing = 22.0;

        final cardHeight = mode.canEdit ? 350.0 : 260.0;

        final totalWidth =
            (cardWidth * columns) +
            (spacing * (columns - 1));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: totalWidth < constraints.maxWidth
                ? constraints.maxWidth
                : totalWidth,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: materials.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                mainAxisExtent: cardHeight,
                childAspectRatio: cardWidth / cardHeight,
              ),
              itemBuilder: (_, index) {
                final material = materials[index];

                return SizedBox(
                  width: cardWidth,
                  child: MaterialCard(
                    material: material,
                    mode: mode,
                    onEdit: () {
                      onEdit?.call(material);
                    },
                    onDelete: () {
                      onDelete?.call(material);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  int _columns(double width) {
    if (width >= 1200) {
      return 4;
    }

    if (width >= 900) {
      return 3;
    }

    return 3;
  }
}