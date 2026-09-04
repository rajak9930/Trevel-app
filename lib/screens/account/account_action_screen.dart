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
          bottomNavigationBar: const BottomNav(),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 32),
              children: [
                Row(children: [IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back)), const SizedBox(width: 8), Expanded(child: Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)))]),
                const SizedBox(height: 10),
                Padding(padding: const EdgeInsets.only(left: 56), child: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 16))),
                const SizedBox(height: 36),
                Center(child: CircleAvatar(radius: 46, backgroundColor: AppColors.blue, child: Icon(icon, size: 42, color: Colors.white))),
                const SizedBox(height: 36),
                _field('Full name', 'Alice Premium'),
                _field('Location', 'Toronto, Canada'),
                _field('Email address', 'alice@example.com'),
                const SizedBox(height: 16),
                FilledButton(onPressed: () => Get.snackbar('Saved', '$title changes saved successfully.', snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16)), child: const Text('Save changes')),
              ],
            ),
          ),
        ),
      );

  Widget _field(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(initialValue: value, decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none))),
      );
}
