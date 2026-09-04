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
          bottomNavigationBar: const BottomNav(),
          body: Obx(
            () => IndexedStack(
              index: controller.selectedTab.value,
              children: const [
                _HomeBody(),
                DetailBody(),
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
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                  fontSize: 34,
                  height: 1.1,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              Text(
                'Prabhat',
                style: TextStyle(
                  fontSize: 34,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1B262E),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 5.5),
                      Container(
                        width: 20,
                        height: 2.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
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

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) => TextField(
        decoration: InputDecoration(
          hintText: 'Search Location',
          hintStyle: const TextStyle(
            color: Color(0xFF8E95A0),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF8E95A0),
            size: 22,
          ),
          suffixIcon: const Icon(
            Icons.mic_none,
            color: Color(0xFF8E95A0),
            size: 22,
          ),
          filled: true,
          fillColor: const Color(0xFF161E26),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      );
}
