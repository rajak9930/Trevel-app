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
          bottomNavigationBar: BottomNav(),
          body: CalendarBody(),
        ),
      );
}

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  int selectedDay = 21;
  String selectedDatesText = 'Mon, Oct 24 – Wed, Oct 26';

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      '2-night stay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      selectedDatesText,
                      style: const TextStyle(
                        color: Color(0xFF8E95A0),
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
                    selectedDay = -1;
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
              color: const Color(0xFF191B1D),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Feb 2026',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _MonthGrid(
                  selectedDay: selectedDay,
                  onSelectDay: (day) {
                    setState(() {
                      selectedDay = day;
                      selectedDatesText = 'Feb $day, 2026';
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Chevrons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.blue,
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 80),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.blue,
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
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
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.selectedDay,
    required this.onSelectDay,
  });

  final int selectedDay;
  final ValueChanged<int> onSelectDay;

  @override
  Widget build(BuildContext context) {
    const days = [
      '1', '2', '3', '4', '5', '6', '7',
      '8', '9', '10', '11', '12', '13', '14',
      '15', '16', '17', '18', '19', '20', '21',
      '22', '23', '24', '25', '26', '27', '28',
      '29', '30', '31', '1', '2', '3', '4',
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
        final dayNum = int.tryParse(dayStr) ?? 0;
        final isAdjacent = (index >= 31);
        final isSelected = (!isAdjacent && dayNum == selectedDay);

        return GestureDetector(
          onTap: isAdjacent ? null : () => onSelectDay(dayNum),
          child: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF383A3C) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  dayStr,
                  style: TextStyle(
                    color: isAdjacent
                        ? Colors.white.withValues(alpha: 0.25)
                        : Colors.white,
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
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


