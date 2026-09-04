import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.size = 48,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.blue,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: iconColor, size: size * .46),
        ),
      ),
    );
  }
}
