 /* import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:flutter/material.dart';

class MaterialModelCard extends StatelessWidget {
  final MaterialItem material;

  final bool canEdit;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MaterialModelCard({
    super.key,
    required this.material,
    this.canEdit = false,
    this.onEdit,
    this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: scheme.outlineVariant.withOpacity(.4),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withOpacity(.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// Category Label
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: Text(
                material.category ?? "-",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,

                  color:
                      scheme.onSecondaryContainer,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),
          /// Name
          Text(
            material.name ?? "-",

            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,

              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          /// Description
          Text(
            material.description ?? "",

            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              height: 1.5,
              fontSize: 14,

              color: scheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          /// Price section
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                "سعر الوحدة",

                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,

                  color:
                      scheme.onSurfaceVariant,
                ),
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                        material.price ?? "0",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.w800,

                        color: scheme.primary,
                      ),
                    ),
                    TextSpan(
                      text: " ل.س",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w500,
                        color:scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          /// Buttons only for manager
          if(canEdit) ...[

            const SizedBox(height: 18),
            Divider(
              color: scheme.outlineVariant,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(

                  child: _ActionButton(
                    text: "تعديل",

                    background:
                        scheme.surfaceContainerLow,

                    foreground:
                        scheme.primary,

                    onTap: onEdit,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    text: "حذف",
                    background:   scheme.errorContainer .withOpacity(.3),
                    foreground:scheme.error,
                    onTap: onDelete,
                  ),
                ),
              ],
            )
          ],
        ],
      ),
    );
  }
}


class _ActionButton extends StatelessWidget {

  final String text;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.text,
    required this.background,
    required this.foreground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.symmetric (vertical: 11,    ),

        decoration: BoxDecoration(
          color: background,
          borderRadius:
          BorderRadius.circular(30),
        ),
        alignment: Alignment.center,

        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.w700,
            color: foreground,

          ),
        ),
      ),
    );
  }
}*/