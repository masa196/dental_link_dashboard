import 'package:flutter/material.dart';

class EmployeeDatePicker {
  static Future<String?> pickMaskedDate(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? closeLabel,
  }) async {
    final picked = await _showCalendarPicker(
      context,
      initialDate,
      firstDate,
      lastDate,
      closeLabel: closeLabel,
    );

    if (picked == null) return null;

    return '${picked.day.toString().padLeft(2, '0')} / ${picked.month.toString().padLeft(2, '0')} / ${picked.year}';
  }

  static Future<int?> _showYearPicker(
    BuildContext ctx,
    int initialYear,
    int firstYear,
    int lastYear,
  ) async {
    return showDialog<int>(
      context: ctx,
      builder: (dialogCtx) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 420),
            child: YearPicker(
              firstDate: DateTime(firstYear, 1, 1),
              lastDate: DateTime(lastYear, 12, 31),
              selectedDate: DateTime(initialYear, 1, 1),
              currentDate: DateTime.now(),
              onChanged: (date) => Navigator.of(dialogCtx).pop(date.year),
            ),
          ),
        );
      },
    );
  }

  static Future<DateTime?> _showCalendarPicker(
    BuildContext ctx,
    DateTime initial,
    DateTime first,
    DateTime last, {
    String? closeLabel,
  }) async {
    final isArabicLocal = ctx.mounted
        ? Directionality.of(ctx) == TextDirection.rtl
        : false;
    DateTime displayed = DateTime(initial.year, initial.month, 1);
    DateTime? selected;

    return showDialog<DateTime>(
      context: ctx,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (dialogCtx, setState) {
            final today = DateTime.now();
            final currentMonthStart = DateTime(today.year, today.month, 1);
            

            final weekdayLabels = isArabicLocal
                ? const [
                    'الأحد',
                    'الاثنين',
                    'الثلاثاء',
                    'الأربعاء',
                    'الخميس',
                    'الجمعة',
                    'السبت',
                  ]
                : const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

            void incMonth(int offset) {
              final nextMonthStart = DateTime(
                displayed.year,
                displayed.month + offset,
                1,
              );
              if (nextMonthStart.isAfter(currentMonthStart)) {
                return;
              }

              setState(() {
                displayed = nextMonthStart;
              });
            }

            return Dialog(
              insetPadding: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 420,
                  maxHeight: MediaQuery.of(dialogCtx).size.height * 0.5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () async {
                              final selectedYear = await _showYearPicker(
                                dialogCtx,
                                displayed.year,
                                first.year,
                                last.year,
                              );
                              if (selectedYear == null) return;
                              setState(() {
                                displayed = DateTime(
                                  selectedYear,
                                  displayed.month,
                                  1,
                                );
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 4,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    MaterialLocalizations.of(dialogCtx)
                                        .formatMonthYear(displayed)
                                        .split(' ')
                                        .first,
                                    style: Theme.of(dialogCtx)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    displayed.year.toString(),
                                    style: Theme.of(dialogCtx)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_drop_down, size: 18),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => incMonth(-1),
                                icon: const Icon(Icons.chevron_left, size: 20),
                              ),
                              IconButton(
                                onPressed: displayed.isBefore(currentMonthStart)
                                    ? () => incMonth(1)
                                    : null,
                                icon: const Icon(Icons.chevron_right, size: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: weekdayLabels
                            .map(
                              (day) => Expanded(
                                child: Center(
                                  child: Text(
                                    day,
                                    style: Theme.of(dialogCtx)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (ctx2, box) {
                            final firstDayOfMonth = DateTime(
                              displayed.year,
                              displayed.month,
                              1,
                            );
                            final leading = firstDayOfMonth.weekday % 7;
                            final daysInMonth = DateTime(
                              displayed.year,
                              displayed.month + 1,
                              0,
                            ).day;
                            final totalCells = leading + daysInMonth;

                            return GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 1.6,
                                  ),
                              itemCount: totalCells,
                              itemBuilder: (context, index) {
                                if (index < leading) {
                                  return const SizedBox.shrink();
                                }

                                final day = index - leading + 1;
                                final date = DateTime(
                                  displayed.year,
                                  displayed.month,
                                  day,
                                );
                                final disabled =
                                    date.isBefore(first) || date.isAfter(last);
                                final isSelected =
                                    today.year == date.year &&
                                    today.month == date.month &&
                                    today.day == date.day;

                                return Center(
                                  child: InkWell(
                                    onTap: disabled
                                        ? null
                                        : () {
                                            selected = date;
                                            Navigator.of(
                                              dialogCtx,
                                            ).pop(selected);
                                          },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(
                                                dialogCtx,
                                              ).colorScheme.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(18),
                                        border: isSelected
                                            ? Border.all(
                                                color: Theme.of(
                                                  dialogCtx,
                                                ).colorScheme.onPrimary,
                                              )
                                            : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        day.toString(),
                                        style: TextStyle(
                                          color: disabled
                                              ? Theme.of(dialogCtx)
                                                    .colorScheme
                                                    .onSurface
                                                  
                                              : (isSelected
                                                    ? Theme.of(
                                                        dialogCtx,
                                                      ).colorScheme.onPrimary
                                                    : Theme.of(
                                                        dialogCtx,
                                                      ).colorScheme.onSurface),
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogCtx).pop(),
                            child: Text(
                              closeLabel ?? (isArabicLocal ? 'إغلاق' : 'Close'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
