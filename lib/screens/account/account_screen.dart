import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/setting_tile.dart';
import '../../widgets/remote_image.dart';
import '../../routes/app_routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) => const AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNav(),
          body: AccountBody(),
        ),
      );
}

class AccountBody extends StatelessWidget {
  const AccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(28, 26, 28, 100),
        children: [
          const Text('Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),
          const RemoteAvatar(
            radius: 42,
            url: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
          ),
          const SizedBox(height: 12),
          const Text(
            'Alice Premium',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const Text('Toronto, Canada', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),
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
            trailing: Obx(
              () => Switch(
                value: controller.isDarkMode.value,
                onChanged: (_) => controller.toggleTheme(),
              ),
            ),
          ),
          SettingTile(
            icon: Icons.help_outline,
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
            trailing: const Text('Coming Soon', style: TextStyle(color: Colors.orange, fontSize: 12)),
            onTap: () => Get.toNamed(AppRoutes.subscription),
          ),
        ],
      ),
    );
  }
}

