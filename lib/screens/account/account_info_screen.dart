import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_background.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key, required this.title, required this.subtitle, required this.icon, required this.action});

  final String title;
  final String subtitle;
  final IconData icon;
  final String action;

  @override
  Widget build(BuildContext context) => AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 32),
              children: [
                Row(children: [IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back)), const SizedBox(width: 8), Expanded(child: Text(title, style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w800)))]),
                Padding(padding: const EdgeInsets.only(left: 56), child: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 16))),
                const SizedBox(height: 44),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFF159CF4), Color(0xFF07517E)]), borderRadius: BorderRadius.circular(30)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    CircleAvatar(radius: 30, backgroundColor: Colors.white24, child: Icon(icon, color: Colors.white, size: 30)),
                    const SizedBox(height: 26),
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 15)),
                  ]),
                ),
                const SizedBox(height: 30),
                _InfoRow(icon: Icons.check_circle_outline, title: 'Personalized experience', text: 'Your preferences stay connected across the app.'),
                _InfoRow(icon: Icons.lock_outline, title: 'Private by design', text: 'Your information is handled with care and clarity.'),
                const SizedBox(height: 18),
                FilledButton.icon(onPressed: () => Get.snackbar(title, action == 'Coming Soon' ? 'This feature will be available soon.' : '$action opened.', snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16)), icon: Icon(action == 'Coming Soon' ? Icons.schedule : Icons.arrow_forward), label: Text(action)),
              ],
            ),
          ),
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, required this.text});
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 20), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: AppColors.blue), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const SizedBox(height: 4), Text(text, style: const TextStyle(color: Colors.grey, height: 1.4))]))]));
}
