import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../controllers/app_controller.dart';
import '../../data/models/destination.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/destination_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<AppController>().zoomDrawerController;
    final size = MediaQuery.sizeOf(context);
    final drawerWidth = size.width * .73;
   return ZoomDrawer(
  controller: drawerController,

  menuScreen: const AppDrawer(),

  menuScreenWidth: drawerWidth,
  slideWidth: drawerWidth,

  mainScreen: AppBackground(
    child: Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: const BottomNav(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
              sliver: SliverToBoxAdapter(
                child: _Header(),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
              sliver: SliverToBoxAdapter(
                child: _SearchField(),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recommended for you',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 30),
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
      ),
    ),
  ),

  mainScreenScale: 0.12,

  angle: 0,

  // Keep the drawer square.
  borderRadius: 42,

  showShadow: false,
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

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
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
      ),
      const Spacer(),
      Builder(
        builder: (context) => IconButton(
          onPressed: () =>
              Get.find<AppController>().zoomDrawerController.open?.call(),
          icon: const Icon(Icons.menu, size: 28),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onSurface
                .withOpacity(.08),
            fixedSize: const Size(64, 64),
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
      prefixIcon: const Icon(Icons.search),
      suffixIcon: const Icon(Icons.mic_none),
      filled: true,
      fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
    ),
  );
}
