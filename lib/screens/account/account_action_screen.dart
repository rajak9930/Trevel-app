import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';

class AccountActionScreen extends StatelessWidget {
  const AccountActionScreen({super.key, required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) => AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SafeArea(
                child: ListView(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 32),
              children: [
                Row(children: [IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back)), const SizedBox(width: 8), Expanded(child: Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)))]),
                const SizedBox(height: 10),
                Padding(padding: const EdgeInsets.only(left: 56), child: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 16))),
                const SizedBox(height: 36),
                Center(child: CircleAvatar(radius: 46, backgroundColor: AppColors.blue, child: Icon(icon, size: 42, color: Colors.white))),
                const SizedBox(height: 36),
                _field(context, 'Full name', 'Alice Premium'),
                _field(context, 'Location', 'Toronto, Canada'),
                _field(context, 'Email address', 'alice@example.com'),
                const SizedBox(height: 16),
                FilledButton(onPressed: () => Get.snackbar('Saved', '$title changes saved successfully.', snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16)), child: const Text('Save changes')),
              ],
                ),
              ),
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

  Widget _field(BuildContext context, String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(initialValue: value, decoration: InputDecoration(labelText: label, filled: true, fillColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08), border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none))),
      );
}
