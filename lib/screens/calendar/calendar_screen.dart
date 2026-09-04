import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) => const AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: Stack(
            children: [
              const CalendarBody(),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 18,
                child: BottomNav(),
              ),
            ],
          ),
        ),
      );
}

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  DateTime? rangeStart;
  DateTime? rangeEnd;
  String selectedDatesText = 'Select your dates';
  DateTime displayedMonth = DateTime(2026, 2);

  static const monthNames = [
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

  void _changeMonth(int offset) {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.year,
        displayedMonth.month + offset,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryText = theme.colorScheme.onSurface;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2-night stay',
                      style: TextStyle(
                        color: primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      selectedDatesText,
                      style: TextStyle(
                        color: primaryText.withValues(alpha: 0.55),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    rangeStart = null;
                    rangeEnd = null;
                    selectedDatesText = 'Dates cleared';
                  });
                  Get.snackbar(
                    'Dates Cancelled',
                    'Your stay dates were cleared.',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Cancel Date',
                    style: TextStyle(
                      color: Color(0xFFFF7A00),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Calendar Card
          Container(
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                    color: theme.brightness == Brightness.dark
                      ? Colors.black.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _changeMonth(-1),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text(
                      '${monthNames[displayedMonth.month - 1]} ${displayedMonth.year}',
                      style: TextStyle(
                        color: primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _changeMonth(1),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _MonthGrid(
                  month: displayedMonth,
                  rangeStart: rangeStart,
                  rangeEnd: rangeEnd,
                  onSelectDay: (date) {
                    setState(() {
                      if (rangeStart == null || rangeEnd != null) {
                        rangeStart = date;
                        rangeEnd = null;
                        selectedDatesText =
                            'Start: ${_dateLabel(date)}';
                      } else if (date.isBefore(rangeStart!)) {
                        rangeStart = date;
                        selectedDatesText =
                            'Start: ${_dateLabel(date)}';
                      } else {
                        rangeEnd = date;
                        selectedDatesText =
                            '${_dateLabel(rangeStart!)} – ${_dateLabel(date)}';
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _changeMonth(-1),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.blue,
                  child: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 80),
              GestureDetector(
                onTap: () => _changeMonth(1),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.blue,
                  child: Icon(
                    Icons.chevron_right,
                    color: primaryText,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _dateLabel(DateTime date) =>
      '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onSelectDay,
  });

  final DateTime month;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final ValueChanged<DateTime> onSelectDay;

  @override
  Widget build(BuildContext context) {
    final firstDayOffset = (DateTime(month.year, month.month, 1).weekday - 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final days = [
      ...List<String?>.filled(firstDayOffset, null),
      ...List<String>.generate(daysInMonth, (index) => '${index + 1}'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 18,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final dayStr = days[index];
        if (dayStr == null) return const SizedBox.shrink();
        final dayNum = int.tryParse(dayStr) ?? 0;
        final date = DateTime(month.year, month.month, dayNum);
        final isStart = date == rangeStart;
        final isEnd = date == rangeEnd;
        final isInRange = rangeStart != null &&
            rangeEnd != null &&
            !date.isBefore(rangeStart!) &&
            !date.isAfter(rangeEnd!);

        return GestureDetector(
          onTap: () => onSelectDay(date),
          child: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isStart || isEnd
                  ? AppColors.blue
                  : isInRange
                    ? AppColors.blue.withValues(alpha: 0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  dayStr,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 15,
                    fontWeight: isStart || isEnd
                      ? FontWeight.w700
                      : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


