import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.month,
    this.selectedDays = const {},
    this.onDaySelected,
  });

  final DateTime month;
  final Set<int> selectedDays;
  final ValueChanged<int>? onDaySelected;

  static const _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leading = first.weekday % 7;
    final cells = leading + daysInMonth;
    final rows = (cells / 7).ceil();
    final total = rows * 7;

    return Column(
      children: [
        Text(
          '${_monthNames[month.month - 1]} ${month.year}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 22),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: total,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 14,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final dayNum = index - leading + 1;
            if (dayNum < 1 || dayNum > daysInMonth) {
              final overflow = dayNum < 1
                  ? DateTime(month.year, month.month, 0).day + dayNum
                  : dayNum - daysInMonth;
              return Center(
                child: Text(
                  '$overflow',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
                    fontSize: 16,
                  ),
                ),
              );
            }
            final selected = selectedDays.contains(dayNum);
            return GestureDetector(
              onTap: onDaySelected == null ? null : () => onDaySelected!(dayNum),
              child: Center(
                child: Text(
                  '$dayNum',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w400,
                    color: selected ? AppColors.blue : null,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
