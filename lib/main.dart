import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'controllers/app_controller.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'screens/account/account_screen.dart';
import 'screens/booking/booking_screen.dart';
import 'screens/detail/detail_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/trips/trips_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/account/account_action_screen.dart';
import 'screens/account/account_info_screen.dart';

void main() {
  debugPaintSizeEnabled = false;
  debugPaintBaselinesEnabled = false;
  debugPaintPointersEnabled = false;
  debugPaintLayerBordersEnabled = false;
  debugRepaintRainbowEnabled = false;

  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<AppController>()
        ? Get.find<AppController>()
        : Get.put(AppController());
    return Obx(() {
      return GetMaterialApp(
        title: 'NextRole Travel',
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 280),
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: controller.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: AppRoutes.home,
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => const HomeScreen(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.trips,
            page: () => const TripsScreen(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.calendar,
            page: () => const CalendarScreen(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.detail,
            page: () => const DetailScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: AppRoutes.booking,
            page: () => const BookingScreen(),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: AppRoutes.account,
            page: () => const AccountScreen(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.editProfile,
            page: () => const AccountActionScreen(
              title: 'Edit Profile',
              subtitle: 'Manage your professional profile',
              icon: Icons.person_outline,
            ),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: AppRoutes.accountSettings,
            page: () => const AccountActionScreen(
              title: 'Account',
              subtitle: 'Manage account and login settings',
              icon: Icons.manage_accounts_outlined,
            ),
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: AppRoutes.notifications,
            page: () => const AccountInfoScreen(
              title: 'Notifications',
              subtitle: 'Stay updated about your trips',
              icon: Icons.notifications_none,
              action: 'Notification settings',
            ),
          ),
          GetPage(
            name: AppRoutes.privacy,
            page: () => const AccountInfoScreen(
              title: 'Privacy & Security',
              subtitle: 'Control your privacy and data',
              icon: Icons.shield_outlined,
              action: 'Review privacy settings',
            ),
          ),
          GetPage(
            name: AppRoutes.help,
            page: () => const AccountInfoScreen(
              title: 'Help & Feedback',
              subtitle: 'We are here to help',
              icon: Icons.help_outline,
              action: 'Contact support',
            ),
          ),
          GetPage(
            name: AppRoutes.invite,
            page: () => const AccountInfoScreen(
              title: 'Invite a Friend',
              subtitle: 'Share better stays with your friends',
              icon: Icons.person_add_alt_1_outlined,
              action: 'Share invite link',
            ),
          ),
          GetPage(
            name: AppRoutes.subscription,
            page: () => const AccountInfoScreen(
              title: 'Subscription',
              subtitle: 'Manage your plan and billing',
              icon: Icons.credit_card_outlined,
              action: 'Coming Soon',
            ),
          ),
        ],
      );
    });
  }
}
