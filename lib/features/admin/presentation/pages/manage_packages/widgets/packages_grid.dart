import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/widgets/package_card.dart';

import 'package:flutter/material.dart';

class PackagesGrid extends StatelessWidget {
  const PackagesGrid({
    super.key,
    required this.packages,
    this.onEdit,
    this.onDelete,
  });

  final List<PackageItemModel> packages;

  final ValueChanged<PackageItemModel>? onEdit;

  final ValueChanged<PackageItemModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final columns = _columns(constraints.maxWidth);

        final cardWidth = 280.0;

        final totalWidth = (cardWidth * columns) + (22 * (columns - 1));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: SizedBox(
            width: totalWidth < constraints.maxWidth
                ? constraints.maxWidth
                : totalWidth,

            child: GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: packages.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,

                crossAxisSpacing: 22,

                mainAxisSpacing: 22,

                mainAxisExtent: 430,

                childAspectRatio: cardWidth / 430,
              ),

              itemBuilder: (_, index) {
                final package = packages[index];

                return SizedBox(
                  width: cardWidth,

                  child: PackageCard(
                    package: package,

                    onEdit: () {
                      onEdit?.call(package);
                    },

                    onDelete: () {
                      onDelete?.call(package);
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

int _columns(double width){

  if(width >= 1300){
    return 4;
  }

  if(width >= 950){
    return 3;
  }

  if(width >= 600){
    return 2;
  }

  return 2;
}

}
