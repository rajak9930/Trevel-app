import 'package:flutter/material.dart';
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
import '../trips/trips_screen.dart';

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
          bottomNavigationBar: const BottomNav(),
          body: Obx(
            () => IndexedStack(
              index: controller.selectedTab.value,
              children: const [
                _HomeBody(),
                TripsBody(),
                CalendarBody(),
                AccountBody(),
              ],
            ),
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
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(28, 24, 28, 0),
            sliver: SliverToBoxAdapter(
              child: _Header(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(28, 28, 28, 20),
            sliver: SliverToBoxAdapter(
              child: _SearchField(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: DestinationCard(
                    destination: destinations[index],
                    index: index,
                  ),
                ),
                childCount: destinations.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: 38,
                  height: 1.05,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Prabhat',
                style: TextStyle(
                  fontSize: 38,
                  height: 1.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () =>
                Get.find<AppController>().zoomDrawerController.open?.call(),
            icon: const Icon(Icons.menu, size: 28),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.08),
              fixedSize: const Size(64, 64),
            ),
          ),
        ],
      );
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) => TextField(
        decoration: InputDecoration(
          hintText: 'Search Location',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.mic_none),
          filled: true,
          fillColor: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: 0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      );
}

