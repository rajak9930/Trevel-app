import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../core/theme/app_theme.dart';
import 'remote_image.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  static const _profile = AppAssets.profileUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(18, 0, 18, 22),
      child: Obx(() {
        final selected = controller.selectedTab.value;
        return Container(
          height: 66,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF13191D).withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              _NavSlot(
                active: selected == 0,
                label: 'Dashboard',
                onTap: () => controller.selectTab(0),
                child: const Icon(Icons.home_outlined),
              ),
              _NavSlot(
                active: selected == 1,
                label: 'Hotels Resort',
                onTap: () => controller.selectTab(1),
                child: const Icon(Icons.flight_takeoff_outlined),
              ),
              _NavSlot(
                active: selected == 2,
                label: 'Booking Hotel',
                onTap: () => controller.selectTab(2),
                child: const Icon(Icons.calendar_month_outlined),
              ),
              _NavSlot(
                active: selected == 3,
                label: 'Account',
                onTap: () => controller.selectTab(3),
                child: const RemoteAvatar(radius: 14, url: _profile),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.active,
    required this.onTap,
    required this.child,
    this.label,
  });

  final bool active;
  final VoidCallback onTap;
  final Widget child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final showLabel = active && label != null;
    final content = Material(
      color: active ? AppColors.blue : Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 56,
          width: showLabel ? null : 56,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: showLabel ? 12 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTheme(
                  data: IconThemeData(
                    color: active
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                    size: 22,
                  ),
                  child: child,
                ),
                if (showLabel) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      label!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (showLabel) return Expanded(child: content);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: content,
    );
  }
}
