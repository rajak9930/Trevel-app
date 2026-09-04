import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../controllers/app_controller.dart';
import '../../data/models/destination.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/destination_card.dart';
import '../account/account_screen.dart';
import '../calendar/calendar_screen.dart';
import '../detail/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final drawerController = controller.zoomDrawerController;
    final size = MediaQuery.sizeOf(context);
    final slideWidth = size.width * 0.74;

    return ZoomDrawer(
      controller: drawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: const AppDrawer(),
      menuScreenWidth: double.infinity,
      slideWidth: slideWidth,
      menuBackgroundColor: const Color(0xFF070B0E),
      mainScreenScale: 0.12,
      borderRadius: 44.0,
      angle: 0.0,
      showShadow: false,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.55),
          blurRadius: 30,
          spreadRadius: 1,
          offset: const Offset(-8, 0),
        ),
      ],
      moveMenuScreen: false,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 320),
      mainScreenTapClose: true,
      androidCloseOnBackTap: true,
      mainScreen: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: Stack(
            children: [
              Obx(
                () => IndexedStack(
                  index: controller.selectedTab.value,
                  children: const [
                    _HomeBody(),
                    _HostelsBody(),
                    CalendarBody(),
                    AccountBody(),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 18,
                child: Obx(
                    () => controller.selectedTab.value == 1 &&
                      controller.isDetailOpen.value
                      ? const SizedBox.shrink()
                      : const BottomNav(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return SafeArea(
      child: Obx(() {
        final query = controller.searchQuery.value.toLowerCase();
        final matches = destinations
            .asMap()
            .entries
            .where((entry) {
              final destination = entry.value;
              return query.isEmpty ||
                  destination.title.toLowerCase().contains(query) ||
                  destination.city.toLowerCase().contains(query) ||
                  destination.country.toLowerCase().contains(query);
            })
            .toList();

        return CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(22, 20, 22, 0),
            sliver: SliverToBoxAdapter(
              child: _Header(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(22, 24, 22, 20),
            sliver: SliverToBoxAdapter(
              child: _SearchField(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 0.1,
              child: OverflowBox(
                minHeight: 0,
                maxHeight: 20,
                child: Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontSize: 1,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 110),
            sliver: matches.isEmpty
                ? const SliverToBoxAdapter(child: _SearchEmptyState())
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DestinationCard(
                          destination: matches[index].value,
                          index: matches[index].key,
                        ),
                      ),
                      childCount: matches.length,
                    ),
                  ),
          ),
        ],
        );
      }),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final primary = Theme.of(context).colorScheme.onSurface;
    final muted = primary.withValues(alpha: 0.55);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      child: Padding(
        key: ValueKey(controller.searchQuery.value),
        padding: const EdgeInsets.only(top: 72, bottom: 80),
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, size: 58, color: muted),
            const SizedBox(height: 16),
            Text(
              'No stays found',
              style: TextStyle(
                color: primary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try another city or country.',
              style: TextStyle(color: muted, fontSize: 14),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: controller.clearSearch,
              icon: const Icon(Icons.refresh),
              label: const Text('Clear search'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HostelsBody extends StatelessWidget {
  const _HostelsBody();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final primaryText = Theme.of(context).colorScheme.onSurface;
    return Obx(
      () => controller.isDetailOpen.value
          ? const DetailBody()
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 120),
                children: [
                  Text(
                    'Hotels Resort',
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose your next stay',
                    style: TextStyle(color: Color(0xFF8E95A0), fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(
                    destinations.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: DestinationCard(
                        destination: destinations[index],
                        index: index,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header();

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  Timer? greetingTimer;

  @override
  void initState() {
    super.initState();
    greetingTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    greetingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryText = Theme.of(context).colorScheme.onSurface;
    final iconBackground = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08);
final hour = DateTime.now().hour;

final greeting = hour >= 5 && hour < 12
    ? 'Good Morning'
    : hour >= 12 && hour < 17
        ? 'Good Afternoon'
        : hour >= 17
            ? 'Good Evening'
            : 'Good Night';
    return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                  fontSize: 34,
                  height: 1.1,
                  fontWeight: FontWeight.w300,
                  color: primaryText,
                ),
              ),
              Text(
                'Prabhat',
                style: TextStyle(
                  fontSize: 34,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  color: primaryText,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () =>
                Get.find<AppController>().zoomDrawerController.open?.call(),
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackground,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.menu,
                    size: 28,
                    color: Colors.transparent,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 20,
                        height: 2.2,
                        decoration: BoxDecoration(
                          color: primaryText,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 5.5),
                      Container(
                        width: 20,
                        height: 2.2,
                        decoration: BoxDecoration(
                          color: primaryText,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField();

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: Get.find<AppController>().searchQuery.value,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.55);
    return Obx(() {
      final query = appController.searchQuery.value;
      if (textController.text != query) {
        textController.value = TextEditingValue(
          text: query,
          selection: TextSelection.collapsed(offset: query.length),
        );
      }
      return TextField(
      controller: textController,
      onChanged: appController.updateSearch,
        decoration: InputDecoration(
          hintText: 'Search Location',
          hintStyle: TextStyle(
            color: muted,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: muted,
            size: 22,
          ),
          suffixIcon: query.isEmpty
              ? Icon(Icons.mic_none, color: muted, size: 22)
              : IconButton(
                  onPressed: () {
                    textController.clear();
                    appController.clearSearch();
                  },
                  icon: Icon(Icons.close, color: muted, size: 22),
                  tooltip: 'Clear search',
                ),
          filled: true,
          fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        );
    });
      }
}
