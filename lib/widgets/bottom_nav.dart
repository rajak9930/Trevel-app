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
        final theme = Theme.of(context);
        return Container(
          height: 66,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color:
                (theme.brightness == Brightness.dark
                        ? AppColors.panel
                        : Colors.white)
                    .withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
         
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxActiveWidth = (constraints.maxWidth - 3 * 56 - 32)
                  .clamp(56.0, double.infinity)
                  .toDouble();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavSlot(
                    active: selected == 0,
                    label: 'Dashboard',
                    maxActiveWidth: maxActiveWidth,
                    onTap: () => controller.selectTab(0),
                    child: const Icon(Icons.home_outlined),
                  ),
                  _NavSlot(
                    active: selected == 1,
                    label: 'Hotels Resort',
                    maxActiveWidth: maxActiveWidth,
                    onTap: () => controller.selectTab(1),
                    child: const Icon(Icons.flight_takeoff_outlined),
                  ),
                  _NavSlot(
                    active: selected == 2,
                    label: 'Booking Hotel',
                    maxActiveWidth: maxActiveWidth,
                    onTap: () => controller.selectTab(2),
                    child: const Icon(Icons.calendar_month_outlined),
                  ),
                  _NavSlot(
                    active: selected == 3,
                    label: 'Account',
                    maxActiveWidth: maxActiveWidth,
                    onTap: () => controller.selectTab(3),
                    child: const RemoteAvatar(radius: 14, url: _profile),
                  ),
                ],
              );
            },
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
    required this.maxActiveWidth,
    this.label,
  });

  final bool active;
  final VoidCallback onTap;
  final Widget child;
  final double maxActiveWidth;
  final String? label;

  static const _duration = Duration(milliseconds: 320);
  static const _curve = Curves.easeOutCubic;

  static const double _collapsedWidth = 56;
  static const double _iconSize = 22;
  static const double _horizontalPadding = 12;
  static const double _labelGap = 8;

  double _expandedWidth(String text) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return (_horizontalPadding * 2) +
        _iconSize +
        _labelGap +
        tp.width +
        4; 
  }

  @override
  Widget build(BuildContext context) {
    final showLabel = active && label != null;
    final expandedWidth = showLabel ? _expandedWidth(label!) : _collapsedWidth;
    final targetWidth = expandedWidth > maxActiveWidth
      ? maxActiveWidth
      : expandedWidth;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: AnimatedContainer(
            duration: _duration,
            curve: _curve,
            height: 56,
            width: targetWidth,
            decoration: BoxDecoration(
              color: active
                  ? AppColors.blue
                  : Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: _duration,
                    curve: _curve,
                    tween: Tween(begin: 0, end: active ? 1 : 0),
                    builder: (context, t, animChild) {
                      return Transform.scale(
                        scale: 1 + (t * 0.12),
                        child: IconTheme(
                          data: IconThemeData(
                            color: Color.lerp(
                              Theme.of(context).colorScheme.onSurface,
                              Colors.white,
                              t,
                            ),
                            size: _iconSize,
                          ),
                          child: animChild!,
                        ),
                      );
                    },
                    child: child,
                  ),
                  Flexible(
                    child: AnimatedSwitcher(
                    duration: _duration,
                    transitionBuilder: (child, animation) {
                      final slide = Tween<Offset>(
                        begin: const Offset(-0.2, 0),
                        end: Offset.zero,
                      ).animate(animation);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(position: slide, child: child),
                      );
                    },
                    child: showLabel
                        ? Padding(
                            key: const ValueKey('label'),
                            padding: const EdgeInsets.only(left: _labelGap),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                label!,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(key: ValueKey('empty'), width: 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}