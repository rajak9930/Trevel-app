import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/destination.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/remote_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;
      final primaryText = theme.colorScheme.onSurface;
      final secondaryText = isDark ? AppColors.muted : const Color(0xFF5F6872);
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
              Positioned(
                top: MediaQuery.paddingOf(context).top + 12,
                left: 18,
                child: _BackButton(
                  onPressed: () {
                    if (controller.isDetailOpen.value ||
                        Get.currentRoute == AppRoutes.home) {
                      controller.closeDestination();
                    } else {
                      Get.back();
                    }
                  },
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
                color: theme.colorScheme.surface,
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
                      Expanded(
                        child: Text(
                          'Hosted by Trang Luxury,\nLifestyle',
                          style: TextStyle(
                            color: primaryText,
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
                      Icon(Icons.star, color: primaryText, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '4.9',
                        style: TextStyle(
                          color: primaryText,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '|',
                        style: TextStyle(
                          color: primaryText.withValues(alpha: 0.3),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '1,648 reviews',
                        style: TextStyle(
                          color: primaryText,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '|',
                        style: TextStyle(
                          color: primaryText.withValues(alpha: 0.3),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'OCT 24 – 26',
                        style: TextStyle(
                          color: primaryText,
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
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '1155 Rue Sherbrooke Ouest, Toronto,\nCanada H3A 2N3',
                          style: TextStyle(
                            color: secondaryText,
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
                Text(
                  'Description',
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  destination.description.isEmpty
                      ? 'Experience a comfortable and memorable stay at our hotel, where modern amenities, warm hospitality, and convenient surroundings come together. Designed for both business and leisure travelers, the hotel offers well-appointed rooms, quality facilities, and attentive service to make every stay relaxing and enjoyable. Guests can enjoy comfortable accommodation, delicious dining options, high-speed Wi-Fi, and convenient access to local attractions.'
                      : destination.description,
                  style: TextStyle(
                    color: secondaryText,
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

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Back',
        ),
      );
}

