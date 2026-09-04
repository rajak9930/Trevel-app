import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/bottom_nav.dart';
import '../account/account_screen.dart';
import '../booking/booking_screen.dart';
import '../detail/detail_screen.dart';
import '../home/home_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    final screenWidth = MediaQuery.sizeOf(context).width;

    // Figma drawer width
    final drawerWidth = screenWidth * 0.74;

    return ZoomDrawer(
      controller: controller.zoomDrawerController,

      style: DrawerStyle.defaultStyle,

      menuScreen: const AppDrawer(),

      menuScreenWidth: drawerWidth,
      slideWidth: drawerWidth,

      menuBackgroundColor: AppColors.dark,

      mainScreen: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,

          bottomNavigationBar: const BottomNav(),

          body: Obx(
            () => IndexedStack(
              index: controller.selectedTab.value,
              children: const [
                HomeScreen(),
                DetailScreen(),
                BookingScreen(),
                AccountScreen(),
              ],
            ),
          ),
        ),
      ),

      // Important
      mainScreenScale: 0.12,
      borderRadius: 42,
      angle: 0,

      showShadow: true,
      moveMenuScreen: false,

      drawerShadowsBackgroundColor: Colors.black,

      shadowLayer1Color: const Color(0xFF06151D),
      shadowLayer2Color: const Color(0xFF0D2D3E),

      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.easeOutCubic,

      duration: const Duration(milliseconds: 320),

      mainScreenTapClose: true,
      androidCloseOnBackTap: true,
    );
  }
}
