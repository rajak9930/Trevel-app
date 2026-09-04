import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/setting_tile.dart';
import '../../routes/app_routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) => const AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          bottomNavigationBar: BottomNav(),
          body: AccountBody(),
        ),
      );
}

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: [
          SettingTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Manage your professional profile',
            onTap: () => Get.toNamed(AppRoutes.editProfile),
          ),
          SettingTile(
            icon: Icons.manage_accounts_outlined,
            title: 'Account',
            subtitle: 'Manage account and login settings',
            onTap: () => Get.toNamed(AppRoutes.accountSettings),
          ),
          SettingTile(
            icon: Icons.notifications_none,
            title: 'Notification',
            subtitle: 'Manage your notification preferences',
            onTap: () => Get.toNamed(AppRoutes.notifications),
          ),
          SettingTile(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'Customize your app experience',
            onTap: () {
              Get.find<AppController>().toggleTheme();
            },
          ),
          SettingTile(
            icon: Icons.chat_bubble_outline,
            title: 'Help & Feedback',
            subtitle: 'Get help or share feedback',
            onTap: () => Get.toNamed(AppRoutes.help),
          ),
          SettingTile(
            icon: Icons.person_add_alt_1_outlined,
            title: 'Invite a friend',
            subtitle: 'Invite friends to NextRole.app',
            onTap: () => Get.toNamed(AppRoutes.invite),
          ),
          SettingTile(
            icon: Icons.shield_outlined,
            title: 'Privacy & Security',
            subtitle: 'Manage privacy and data settings',
            onTap: () => Get.toNamed(AppRoutes.privacy),
          ),
          SettingTile(
            icon: Icons.credit_card_outlined,
            title: 'Subscription',
            subtitle: 'Manage your plan and billing',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF3B2A12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Coming Soon',
                style: TextStyle(
                  color: Color(0xFFFF9D00),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () => Get.toNamed(AppRoutes.subscription),
          ),
        ],
      ),
    );
  }
}

