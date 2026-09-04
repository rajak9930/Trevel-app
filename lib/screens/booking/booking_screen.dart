import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_background.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool isConfirming = false;
  bool isConfirmed = false;

  Future<void> _openConfirmationSheet(DateTime start, DateTime end) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.blue.withValues(alpha: 0.14),
                    child: const Icon(Icons.check_circle_outline, color: AppColors.blue),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Confirm your booking',
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _BookingDetail(label: 'Booking ID', value: 'TQM-2026-02425'),
              _BookingDetail(label: 'Destination', value: 'Toronto, Canada'),
              _BookingDetail(label: 'Dates', value: '${_dateLabel(start)} – ${_dateLabel(end)}'),
              _BookingDetail(label: 'Guests', value: '2 guests'),
              _BookingDetail(label: 'Total', value: '\$50.00'),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(sheetContext, true),
                  icon: const Icon(Icons.lock_outline),
                  label: const Text('Confirm and reserve'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => isConfirming = true);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;
    final controller = Get.find<AppController>();
    controller.selectTab(0);
    Get.offAllNamed(AppRoutes.home);
    Get.snackbar(
      'Booking confirmed',
      'Toronto stay reserved • TQM-2026-02425',
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      borderRadius: 18,
      backgroundColor: const Color(0xFF159CF4),
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final start = controller.bookingStart.value ?? DateTime(2026, 2, 24);
    final end = controller.bookingEnd.value ?? DateTime(2026, 2, 25);
    final dateText = '${_dateLabel(start)} – ${_dateLabel(end)}';
    return AppBackground(child: Scaffold(backgroundColor: Colors.transparent, body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(28, 24, 28, 32), children: [
    Row(children: [IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back)), const SizedBox(width: 8), const Text('2-night stay', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)), const Spacer(), const Text('Cancel Date', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700))]),
    Padding(padding: const EdgeInsets.only(left: 56, top: 2), child: Text(dateText, style: const TextStyle(color: Colors.grey, fontSize: 17))),
    const SizedBox(height: 64),
    Container(padding: const EdgeInsets.fromLTRB(18, 20, 18, 24), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(32), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1))), child: Column(children: [Text('${_monthName(start.month)} ${start.year}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), const SizedBox(height: 28), _CalendarGrid(start: start, end: end) ])),
    const SizedBox(height: 36), Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(backgroundColor: AppColors.blue, child: Icon(Icons.chevron_left)), const SizedBox(width: 90), CircleAvatar(backgroundColor: AppColors.blue, child: Icon(Icons.chevron_right))]),
    const SizedBox(height: 34), FilledButton.icon(onPressed: isConfirming || isConfirmed ? null : () => _openConfirmationSheet(start, end), icon: isConfirming ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Icon(isConfirmed ? Icons.check_circle_outline : Icons.calendar_month_outlined), label: Text(isConfirming ? 'Confirming...' : isConfirmed ? 'Booking confirmed' : 'Confirm booking')),
  ]))));
  }

  String _dateLabel(DateTime date) => '${_monthName(date.month)} ${date.day}, ${date.year}';
  String _monthName(int month) => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][month - 1];
}

class _BookingDetail extends StatelessWidget {
  const _BookingDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.58))),
            Flexible(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w700))),
          ],
        ),
      );
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({required this.start, required this.end});
  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(start.year, start.month + 1, 0).day;
    final days = List.generate(daysInMonth, (index) => index + 1);
    return GridView.count(crossAxisCount: 7, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 22, children: days.map((day) {
      final date = DateTime(start.year, start.month, day);
      final selected = date == start || date == end;
      return Center(child: Text('$day', style: TextStyle(color: selected ? AppColors.blue : null, fontWeight: selected ? FontWeight.w800 : null)));
    }).toList());
  }
}
