import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});
  @override
  Widget build(BuildContext context) => AppBackground(child: Scaffold(backgroundColor: Colors.transparent, bottomNavigationBar: const BottomNav(), body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(28, 24, 28, 30), children: [
    Row(children: [IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back)), const SizedBox(width: 8), const Text('2-night stay', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)), const Spacer(), const Text('Cancel Date', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700))]),
    const Padding(padding: EdgeInsets.only(left: 56, top: 2), child: Text('Mon, Oct 24 – Wed, Oct 26', style: TextStyle(color: Colors.grey, fontSize: 17))),
    const SizedBox(height: 64),
    Container(padding: const EdgeInsets.fromLTRB(18, 20, 18, 24), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(32), border: Border.all(color: Colors.white10)), child: Column(children: [const Text('February 2026', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), const SizedBox(height: 28), _CalendarGrid() ])),
    const SizedBox(height: 36), Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(backgroundColor: AppColors.blue, child: Icon(Icons.chevron_left)), const SizedBox(width: 90), CircleAvatar(backgroundColor: AppColors.blue, child: Icon(Icons.chevron_right))]),
    const SizedBox(height: 34), FilledButton.icon(onPressed: () => Get.snackbar('Booking confirmed', 'Your Toronto stay is reserved.', snackPosition: SnackPosition.BOTTOM), icon: const Icon(Icons.calendar_month_outlined), label: const Text('Confirm booking')),
  ]))));
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) { final days = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','1','2','3','4']; return GridView.count(crossAxisCount: 7, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 22, children: days.map((day) => Center(child: Text(day, style: TextStyle(color: day == '24' || day == '25' ? AppColors.blue : null, fontWeight: day == '24' || day == '25' ? FontWeight.w800 : null)))).toList()); }
}
