import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AppController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  final selectedTab = 0.obs;
  final isDarkMode = true.obs;
  final selectedDestination = 0.obs;
  final searchQuery = ''.obs;
  final selectedDrawerItem = 'payment'.obs;
  final visibleMonth = DateTime(2026, 2).obs;
  final selectedDays = <int>{24, 25}.obs;

  void selectDrawerItem(String id) {
    selectedDrawerItem.value = id;
  }

  void selectTab(int index) {
    selectedTab.value = index;
    zoomDrawerController.close?.call();
    if (Get.currentRoute != AppRoutes.home) {
      Get.until((route) => route.settings.name == AppRoutes.home);
    }
  }

  void selectRouteTab(int index, String route) {
    selectTab(index);
  }

  void openDestination(int index) {
    selectedDestination.value = index;
    selectTab(1);
  }

  void shiftMonth(int delta) {
    final current = visibleMonth.value;
    visibleMonth.value = DateTime(current.year, current.month + delta);
  }

  void toggleDay(int day) {
    final next = {...selectedDays};
    if (next.contains(day)) {
      next.remove(day);
    } else {
      next.add(day);
    }
    selectedDays.assignAll(next);
  }

  void cancelDates() {
    selectedDays.clear();
    Get.snackbar(
      'Dates cancelled',
      'Your selected stay dates were cleared.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
