import 'package:flutter/material.dart';

class AppColors {
  static const blue = Color(0xFF0095FF);
  static const dark = Color(0xFF090D0E);
  static const panel = Color(0xFF1C1C1E);
  static const muted = Color(0xFF9EA4AA);
  static const orange = Color(0xFFFF9D00);
  static const badge = Color(0xFFFFA500);
  static const comingSoonBg = Color(0xFF3B2A12);
  static const lightBackground = Color(0xFFF5F7F8);
  static const lightPanel = Colors.white;
}

class AppRadii {
  static const pill = 40.0;
  static const card = 32.0;
  static const image = 36.0;
  static const nav = 40.0;
  static const icon = 22.0;
}

class AppSpacing {
  static const screen = 20.0;
  static const navBottom = 12.0;
  static const item = 12.0;
  static const section = 24.0;
}

class AppAssets {
  static const profileUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200';
}

class AppTheme {
  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.blue,
          surface: AppColors.panel,
        ),
        fontFamily: 'Arial',
        useMaterial3: true,
        filledButtonTheme: _filledButton(),
      );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: AppColors.blue,
          surface: AppColors.lightPanel,
        ),
        fontFamily: 'Arial',
        useMaterial3: true,
        filledButtonTheme: _filledButton(),
      );

  static FilledButtonThemeData _filledButton() => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      );
}
