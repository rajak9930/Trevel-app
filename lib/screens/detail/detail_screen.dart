import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/destination.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/remote_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: BottomNav(),
        body: DetailBody(),
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Obx(() {
      final destIndex = controller.selectedDestination.value.clamp(0, destinations.length - 1);
      final destination = destinations[destIndex];

      return ListView(
        padding: EdgeInsets.zero,
        children: [
          // Hero Image with carousel indicators
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 360,
                width: double.infinity,
                child: RemoteImage(
                  url: destination.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              // Carousel pill indicators
              Positioned(
                bottom: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7A00),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Floating sheet card overlapping image
          Transform.translate(
            offset: const Offset(0, -12),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
              decoration: BoxDecoration(
                color: const Color(0xFF191B1D),
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Host row
                  Row(
                    children: [
                      const RemoteAvatar(
                        radius: 30,
                        url: AppAssets.profileUrl,
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Text(
                          'Hosted by Trang Luxury,\nLifestyle',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Ratings and reviews row
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      const Text(
                        '4.9',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        '1,648 reviews',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'OCT 24 – 26',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Location address row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: AppColors.blue,
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          '1155 Rue Sherbrooke Ouest, Toronto,\nCanada H3A 2N3',
                          style: TextStyle(
                            color: Color(0xFF9EA4AA),
                            fontSize: 14,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Description section
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  destination.description.isEmpty
                      ? 'Experience a comfortable and memorable stay at our hotel, where modern amenities, warm hospitality, and convenient surroundings come together. Designed for both business and leisure travelers, the hotel offers well-appointed rooms, quality facilities, and attentive service to make every stay relaxing and enjoyable. Guests can enjoy comfortable accommodation, delicious dining options, high-speed Wi-Fi, and convenient access to local attractions.'
                      : destination.description,
                  style: const TextStyle(
                    color: Color(0xFF8E95A0),
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

