import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) => const AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNav(),
          body: CalendarBody(),
        ),
      );
}

class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 100),
          children: [
            const Text('Calendar', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Plan your next escape', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
                    const Text('February 2026', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
                  ],
                ),
                const SizedBox(height: 22),
                const _MonthGrid(),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('Selected stay', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                children: [
                  Icon(Icons.hotel_outlined, color: AppColors.blue),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Toronto, Canada\nOct 24 – Oct 26',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Get.toNamed(AppRoutes.booking),
              child: const Text('Open booking calendar'),
            ),
          ],
        ),
      );
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid();
  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28'];
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      children: days.map(
        (day) => Center(
          child: Text(
            day,
            style: TextStyle(
              color: day == '24' || day == '25'
                  ? AppColors.blue
                  : day.length == 1 && int.tryParse(day) == null
                      ? Colors.grey
                      : null,
              fontWeight: day == '24' || day == '25' ? FontWeight.w800 : null,
            ),
          ),
        ),
      ).toList(),
    );
  }
}

