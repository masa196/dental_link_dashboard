import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/manage_materials/widgets/materials_mode.dart';
import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.material,
    required this.mode,
    this.onEdit,
    this.onDelete,
  });

  final MaterialItem material;
  final MaterialsMode mode;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: .4)),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: .05),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryBadge(category: material.category),

          const SizedBox(height: 16),

          Text(
            material.name ?? "-",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 16,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            material.description ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 14,
              height: 1.6,
            ),
          ),

          if (mode.canEdit) const Spacer() else const SizedBox(height: 50),

          _PriceSection(price: material.price),

          if (mode.canEdit) ...[
            const SizedBox(height: 18),

            Divider(color: scheme.outlineVariant),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    title: "تعديل",
                    background: scheme.primary.withAlpha(12),
                    color: scheme.primary,
                    onTap: onEdit,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _ActionButton(
                    title: "حذف",
                    background: scheme.errorContainer.withValues(alpha: 0.1),
                    color: scheme.error,
                    onTap: onDelete,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});

  final String? category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: scheme.secondaryContainer,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          category ?? "-",
          style: TextStyle(
            color: scheme.onSecondaryContainer,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({required this.price});

  final String? price;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "السعر ",
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: price ?? "0",
                style: TextStyle(
                  color: scheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),

              TextSpan(
                text: " ل.س",
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.background,
    required this.color,
    this.onTap,
  });

  final String title;
  final Color background;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
        ),

        alignment: Alignment.center,

        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
