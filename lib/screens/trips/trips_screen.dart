import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/destination.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) => const AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              const TripsBody(),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 18,
                child: BottomNav(),
              ),
            ],
          ),
        ),
      );
}

class TripsBody extends StatelessWidget {
  const TripsBody({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 100),
          children: [
            const Text('My Trips', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Your stays, all in one place', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 30),
            _TripCard(destination: destinations.first, status: 'Upcoming'),
            const SizedBox(height: 18),
            const Text('Past stays', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            const _EmptyPastTrips(),
          ],
        ),
      );
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.destination, required this.status});
  final Destination destination;
  final String status;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.detail, arguments: 0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            ),
          ),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                destination.imageUrl,
                width: 92,
                height: 112,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 92,
                  height: 112,
                  color: AppColors.blue.withValues(alpha: 0.25),
                  child: const Icon(Icons.hotel),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status, style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(destination.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(destination.available, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  const Text('View details', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ]),
        ),
      );
}

class _EmptyPastTrips extends StatelessWidget {
  const _EmptyPastTrips();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          children: [
            Icon(Icons.luggage_outlined, size: 36, color: Colors.grey),
            SizedBox(height: 10),
            Text('No past stays yet', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 5),
            Text('Your completed trips will appear here.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
}

