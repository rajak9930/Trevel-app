import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: Theme.of(context).brightness == Brightness.dark
              ? const [Color(0xFF0B2738), AppColors.dark, Color(0xFF08273A)]
              : const [Color(0xFFE4F5FF), AppColors.lightBackground, Color(0xFFDFF2FF)],
        ),
      ),
      child: child,
    );
  }
}
