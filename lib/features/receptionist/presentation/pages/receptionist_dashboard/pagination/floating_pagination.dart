import 'package:flutter/material.dart';

class FloatingPagination extends StatelessWidget {
  const FloatingPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxVisiblePages = 5,
    this.compact = true,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  /// Maximum page numbers shown (without arrows)
  final int maxVisiblePages;

  /// Compact layout (32px height) or normal (40px)
  final bool compact;

  @override
  Widget build(BuildContext context) {
    List<_PaginationItem> _visiblePages() {
      if (totalPages <= maxVisiblePages + 2) {
        return List.generate(totalPages, (i) => _PaginationItem.page(i + 1));
      }

      final items = <_PaginationItem>[];

      // Always show first page
      items.add(const _PaginationItem.page(1));

      int start = currentPage - 1;
      int end = currentPage + 1;

      if (start < 2) {
        start = 2;
        end = 4;
      }

      if (end > totalPages - 1) {
        end = totalPages - 1;
        start = totalPages - 3;
      }

      if (start > 2) {
        items.add(const _PaginationItem.ellipsis());
      }

      for (int i = start; i <= end; i++) {
        items.add(_PaginationItem.page(i));
      }

      if (end < totalPages - 1) {
        items.add(const _PaginationItem.ellipsis());
      }

      items.add(_PaginationItem.page(totalPages));

      return items;
    }

    final scheme = Theme.of(context).colorScheme;

    final height = compact ? 32.0 : 40.0;

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavButton(
            icon: Icons.chevron_left,
            enabled: currentPage > 1,
            onTap: () => onPageChanged(currentPage - 1),
          ),

          const SizedBox(width: 4),

          ..._visiblePages().map((item) {
            if (item.isEllipsis) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "...",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              );
            }

            final page = item.page!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _PageItem(
                label: "$page",
                selected: page == currentPage,
                onTap: () {
                  if (page == currentPage) return;

                  onPageChanged(page);
                },
              ),
            );
          }),
          const SizedBox(width: 4),

          _NavButton(
            icon: Icons.chevron_right,
            enabled: currentPage < totalPages,
           onTap: () => onPageChanged(currentPage + 1),
          ),
        ],
      ),
    );
  }
}

class _PaginationItem {
  const _PaginationItem.page(this.page) : isEllipsis = false;

  const _PaginationItem.ellipsis() : page = null, isEllipsis = true;

  final int? page;
  final bool isEllipsis;
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 18),
      visualDensity: VisualDensity.compact,
      splashRadius: 18,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
    );
  }
}

class _PageItem extends StatelessWidget {
  const _PageItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? scheme.onPrimaryContainer : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
