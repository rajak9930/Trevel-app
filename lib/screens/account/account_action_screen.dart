import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_background.dart';

class AccountActionScreen extends StatefulWidget {
  const AccountActionScreen({super.key, required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  State<AccountActionScreen> createState() => _AccountActionScreenState();
}

class _AccountActionScreenState extends State<AccountActionScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.onSurface;
    final muted = primary.withValues(alpha: 0.58);
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    18,
                    20,
                    MediaQuery.paddingOf(context).bottom + 28,
                  ),
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: Get.back,
                          tooltip: 'Back',
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color: primary,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 56),
                      child: Text(
                        widget.subtitle,
                        style: TextStyle(color: muted, fontSize: 16, height: 1.35),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Center(
                      child: Container(
                        width: 124,
                        height: 124,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF20A7FF), AppColors.blue],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blue.withValues(alpha: 0.28),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(widget.icon, size: 52, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 38),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _field(context, 'Full name', 'Alice Premium', Icons.person_outline),
                          _field(context, 'Location', 'Toronto, Canada', Icons.location_on_outlined),
                          _field(context, 'Email address', 'alice@example.com', Icons.mail_outline),
                          _field(context, 'Phone number', '+1 416 555 0198', Icons.phone_outlined),
                          _field(context, 'Travel preference', 'City breaks and boutique stays', Icons.flight_takeoff_outlined),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: isSaving ? null : _save,
                        icon: const Icon(Icons.check_rounded, size: 20),
                        label: isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Save changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => isSaving = false);
    Get.snackbar(
      'Saved',
      '${widget.title} changes saved successfully.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  Widget _field(BuildContext context, String label, String value, IconData fieldIcon) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.58);
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          initialValue: value,
          validator: (text) {
            if (text == null || text.trim().isEmpty) {
              return '$label is required';
            }
            if (label == 'Email address' && !text.contains('@')) {
              return 'Enter a valid email address';
            }
            return null;
          },
          style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 17),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: muted),
            prefixIcon: Icon(fieldIcon, color: muted, size: 21),
            filled: true,
            fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
            ),
          ),
        ),
      );
  }
}
