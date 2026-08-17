import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:dental_link_dashboard/features/admin/presentation/pages/manage_packages/packages_page.dart';
import 'package:flutter/material.dart';

class PackageCard extends StatefulWidget {
  const PackageCard({
    super.key,
    required this.package,
    required this.mode,
    this.onEdit,
    this.onDelete,
  });

  final PackageItemModel package;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final PackagesPageMode mode;

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAdmin = widget.mode == PackagesPageMode.admin;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovered = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: hovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(26),

          boxShadow: [
            BoxShadow(
              color: hovered
                  ? scheme.primary.withValues(alpha: .12)
                  : Colors.black.withValues(alpha: .04),
              blurRadius: hovered ? 28 : 18,
              offset: const Offset(0, 12),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusBadge(active: widget.package.isActive),
            const SizedBox(height: 12),
            Text(
              widget.package.name ?? "-",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            _DurationCard(days: widget.package.durationDays),
            const SizedBox(height: 10),
            _DescriptionCard(description: widget.package.description),
            const SizedBox(height: 8),
            Divider(color: scheme.outlineVariant),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "السعر",

                    style: TextStyle(
                      color: scheme.onSurfaceVariant,

                      fontSize: 15,

                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.package.price ?? "0",

                          style: TextStyle(
                            fontSize: 20,

                            fontWeight: FontWeight.w900,

                            color: scheme.primary,
                          ),
                        ),

                        TextSpan(
                          text: " ل.س",

                          style: TextStyle(
                            fontSize: 14,

                            fontWeight: FontWeight.w700,

                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            if (isAdmin) ...[
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      title: "تعديل",
                      color: scheme.primary,
                      background: scheme.primary.withValues(alpha: .12),
                      onTap: widget.onEdit,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _ActionButton(
                      title: "حذف",
                      color: scheme.error,
                      background: scheme.error.withValues(alpha: .12),
                      onTap: widget.onDelete,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.active});

  final bool? active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final isActive = active == true;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),

      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withValues(alpha: .12)
            : scheme.error.withValues(alpha: .12),

        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(
            isActive
                ? Icons.check_circle_outline_rounded
                : Icons.cancel_outlined,

            size: 17,

            color: isActive ? Colors.green : scheme.error,
          ),

          const SizedBox(width: 6),

          Text(
            isActive ? "متاحة" : "غير متاحة",

            style: TextStyle(
              color: isActive ? Colors.green : scheme.error,

              fontSize: 13,

              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationCard extends StatelessWidget {
  const _DurationCard({required this.days});

  final int? days;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: .08),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: .15),

              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.access_time_rounded,

              size: 18,

              color: scheme.primary,
            ),
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "مدة الاشتراك",

                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),

              const SizedBox(height: 3),

              Text(
                _formatDuration(days),

                style: TextStyle(
                  fontSize: 14,

                  fontWeight: FontWeight.w800,

                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(int? days) {
    if (days == null || days <= 0) {
      return "-";
    }

    // سنة كاملة
    if (days >= 360 && days <= 370) {
      return "سنة";
    }

    final months = days ~/ 30;

    final remainingDays = days % 30;

    if (months > 0 && remainingDays == 0) {
      if (months == 1) {
        return "شهر واحد";
      }

      if (months == 2) {
        return "شهران";
      }

      return "$months أشهر";
    }

    if (months > 0) {
      if (months == 1) {
        return "شهر و $remainingDays يوم";
      }

      return "$months أشهر و $remainingDays يوم";
    }

    return "$days يوم";
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final text = description?.trim().isNotEmpty == true
        ? description!.trim()
        : "لا يوجد وصف";

    final isLong = text.length > 80;

    return Container(
      width: double.infinity,

      height: 95,

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: .45),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "وصف الباقة",

            style: TextStyle(
              fontSize: 13,

              fontWeight: FontWeight.w700,

              color: scheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 5),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Expanded(
                child: SizedBox(
                  height: 38,

                  child: Text(
                    text,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    textDirection: TextDirection.rtl,

                    style: TextStyle(
                      fontSize: 14,

                      height: 1.4,

                      color: scheme.onSurface,
                    ),
                  ),
                ),
              ),

              if (isLong)
                InkWell(
                  onTap: () {
                    _showFullDescription(context, text);
                  },

                  child: Text(
                    "عرض",

                    style: TextStyle(
                      fontSize: 12,

                      fontWeight: FontWeight.w700,

                      color: scheme.primary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFullDescription(BuildContext context, String description) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text("وصف الباقة"),

          content: SingleChildScrollView(
            child: Text(description, textDirection: TextDirection.rtl),
          ),
        );
      },
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
      onTap: onTap,

      borderRadius: BorderRadius.circular(18),

      child: Container(
        height: 34,

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: background,

          borderRadius: BorderRadius.circular(18),
        ),

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
