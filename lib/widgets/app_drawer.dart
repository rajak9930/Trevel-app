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
    return SizedBox.expand(
  child: Stack(
    children: [
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF090D0E),
              Color(0xFF0A141C),
              Color(0xFF0B2A40),
            ],
          ),
        ),
        child: SizedBox.expand(),
      ),

      // existing glow
      Positioned(
        left: -90,
        bottom: -70,
        child: IgnorePointer(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.blue.withOpacity(.38),
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
            _DrawerHeader(controller),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [
                  const _SectionLabel(),

                  _DrawerItem(
                    id: 'notification',
                    icon: Icons.notifications_none,
                    label: 'Notification',
                    badge: '12',
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
                    onTap: () =>
                        controller.selectDrawerItem('translate'),
                  ),

                  _DrawerItem(
                    id: 'privacy',
                    icon: Icons.lock_outline,
                    label: 'Privacy',
                    onTap: () => _open(
                      controller,
                      'privacy',
                      AppRoutes.privacy,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const _SectionLabel(),

                  _DrawerItem(
                    id: 'listing',
                    icon: Icons.list_alt_outlined,
                    label: 'Listing',
                    onTap: () =>
                        controller.selectDrawerItem('listing'),
                  ),

                  _DrawerItem(
                    id: 'host',
                    icon: Icons.people_outline,
                    label: 'Host',
                    onTap: () =>
                        controller.selectDrawerItem('host'),
                  ),

                  const SizedBox(height: 18),

                  const _SectionLabel(),

                  _DrawerItem(
                    id: 'dark_mode',
                    icon: Icons.dark_mode_outlined,
                    label: 'Dark Mode',
                    onTap: () {
                      controller.selectDrawerItem('dark_mode');
                      controller.toggleTheme();
                    },
                  ),

                  _DrawerItem(
                    id: 'update',
                    icon: Icons.system_update_outlined,
                    label: 'Update',
                    onTap: () =>
                        controller.selectDrawerItem('update'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
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
  const _SectionLabel();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 18, bottom: 10, top: 4),
      child: Text(
        'Account Setting',
        style: TextStyle(
          color: Color(0xFF8B939A),
          fontSize: 13,
          fontWeight: FontWeight.w500,
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
    this.badge,
  });

  final String id;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<AppController>();

      final selected =
          controller.selectedDrawerItem.value == id;

      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Material(
          color: selected
              ? AppColors.blue
              : Colors.transparent,

          // Only right side rounded
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(40),
          ),

          child: InkWell(
            onTap: onTap,

            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(40),
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                8,
                14,
                8,
              ),

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27,

                    backgroundColor: selected
                        ? Colors.white
                        : Colors.white.withOpacity(.08),

                    child: Icon(
                      icon,
                      size: 22,
                      color: selected
                          ? AppColors.blue
                          : Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),

                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB020),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: Colors.white.withOpacity(
                        selected ? .9 : .45,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
Widget _DrawerHeader(AppController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(28, 12, 10, 0),
    child: Row(
      children: [
        const RemoteAvatar(
          radius: 28,
          url:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alice Premium',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 2),

              Text(
                'Toronto, Canada',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF9EA4AA),
                  fontSize: 13,
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
            size: 28,
          ),
        ),
      ],
    ),
  );
}