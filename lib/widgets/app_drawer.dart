import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../core/theme/app_theme.dart';
import '../routes/app_routes.dart';
import 'remote_image.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
   
    final drawerMenuWidth = (screenWidth * 0.65).clamp(220.0, 275.0);

    return Material(
      type: MaterialType.transparency,
      child: DefaultTextStyle(
        style: TextStyle(
          fontFamily: 'Arial',
          decoration: TextDecoration.none,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: SizedBox.expand(
          child: Stack(
            children: [
          
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? const [
                            Color(0xFF070B0E),
                            Color(0xFF09141D),
                            Color(0xFF0A273D),
                          ]
                        : const [
                            Color(0xFFF5F7F8),
                            Colors.white,
                            Color(0xFFE4F5FF),
                          ],
                  ),
                ),
                child: SizedBox.expand(),
              ),

             
              Positioned(
                top: -40,
                right: 20,
                child: IgnorePointer(
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.blue.withValues(alpha: 0.28),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: -80,
                bottom: -60,
                child: IgnorePointer(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.blue.withValues(alpha: 0.24),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DrawerHeader(
                      controller: controller,
                      width: drawerMenuWidth,
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _SectionLabel(leftPadding: 20),
                          _DrawerItem(
                            id: 'notification',
                            icon: Icons.notifications_none,
                            label: 'Notification',
                            badge: '12',
                            width: drawerMenuWidth,
                            onTap: () => _open(
                              controller,
                              'notification',
                              AppRoutes.notifications,
                            ),
                          ),
                          _DrawerItem(
                            id: 'payment',
                            icon: Icons.credit_card_outlined,
                            label: 'Payment',
                            width: drawerMenuWidth,
                            onTap: () => _open(
                              controller,
                              'payment',
                              AppRoutes.subscription,
                            ),
                          ),
                          _DrawerItem(
                            id: 'translate',
                            icon: Icons.translate,
                            label: 'Translate',
                            width: drawerMenuWidth,
                            onTap: () =>
                                controller.selectDrawerItem('translate'),
                          ),
                          _DrawerItem(
                            id: 'privacy',
                            icon: Icons.lock_outline,
                            label: 'Privacy',
                            width: drawerMenuWidth,
                            onTap: () => _open(
                              controller,
                              'privacy',
                              AppRoutes.privacy,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _SectionLabel(leftPadding: 20),
                          _DrawerItem(
                            id: 'listing',
                            icon: Icons.list_alt_outlined,
                            label: 'Listing',
                            width: drawerMenuWidth,
                            onTap: () =>
                                controller.selectDrawerItem('listing'),
                          ),
                          _DrawerItem(
                            id: 'host',
                            icon: Icons.people_outline,
                            label: 'Host',
                            width: drawerMenuWidth,
                            onTap: () =>
                                controller.selectDrawerItem('host'),
                          ),
                          const SizedBox(height: 12),
                          _SectionLabel(leftPadding: 20),
                          Obx(
                            () => _DrawerItem(
                              id: 'dark_mode',
                              icon: controller.isDarkMode.value
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              label: controller.isDarkMode.value
                                  ? 'Light Mode'
                                  : 'Dark Mode',
                              showChevron: false,
                              width: drawerMenuWidth,
                              onTap: () {
                                controller.selectDrawerItem('dark_mode');
                                controller.toggleTheme();
                              },
                            ),
                          ),
                          _DrawerItem(
                            id: 'update',
                            icon: Icons.system_update_outlined,
                            label: 'Update',
                            width: drawerMenuWidth,
                            onTap: () =>
                                controller.selectDrawerItem('update'),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _open(AppController controller, String id, String route) {
    controller.selectDrawerItem(id);
    controller.zoomDrawerController.close?.call();
    Get.toNamed(route);
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.leftPadding});
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: 12, bottom: 8),
      child: const Text(
        'Account Setting',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 13,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.id,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.width,
    this.badge,
    this.showChevron = true,
  });

  final String id;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double width;
  final String? badge;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.onSurface;
    return Obx(() {
      final controller = Get.find<AppController>();
      final selected = controller.selectedDrawerItem.value == id;

      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SizedBox(
          width: width,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: selected ? AppColors.blue : Colors.transparent,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(30),
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(30),
                ),
                child: Container(
                  width: width,
                  padding: const EdgeInsets.fromLTRB(20, 6, 16, 6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: selected
                            ? Colors.white
                            : primary.withValues(alpha: 0.08),
                        child: Icon(
                          icon,
                          size: 21,
                          color: selected ? AppColors.blue : primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: primary,
                            fontSize: 16,
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      if (badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFAC1C),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            badge!,
                            style: TextStyle(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                      else if (showChevron)
                        Icon(
                          Icons.chevron_right,
                          size: 22,
                          color: primary.withValues(
                            alpha: selected ? 0.95 : 0.45,
                          ),
                        )
                      else
                        const SizedBox(width: 22),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    required this.controller,
    required this.width,
  });

  final AppController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.onSurface;
    final secondary = primary.withValues(alpha: 0.6);
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 8, 0),
        child: Row(
          children: [
            const RemoteAvatar(
              radius: 25,
              url:
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Alice Premium',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Toronto, Canada',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: secondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () =>
                  controller.zoomDrawerController.close?.call(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}