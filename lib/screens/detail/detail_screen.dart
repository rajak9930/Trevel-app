import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/destination.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_background.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/remote_image.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final destination = destinations[Get.arguments as int? ?? 0];
    return AppBackground(child: Scaffold(backgroundColor: Colors.transparent, bottomNavigationBar: const BottomNav(), body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(0, 0, 0, 24), children: [
      Stack(children: [SizedBox(height: 330, width: double.infinity, child: RemoteImage(url: destination.imageUrl)), Positioned(top: 16, left: 20, child: CircleAvatar(backgroundColor: Colors.black54, child: IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back))))]),
      Transform.translate(offset: const Offset(0, -4), child: Container(padding: const EdgeInsets.fromLTRB(28, 28, 28, 30), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(36))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const RemoteAvatar(radius: 34, url: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200'), const SizedBox(width: 16), Expanded(child: Text('Hosted by Trang Luxury,\nLifestyle', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800))),]),
        const SizedBox(height: 28), Row(children: [Icon(Icons.star, color: Theme.of(context).colorScheme.onSurface), const SizedBox(width: 8), const Text('4.9'), const SizedBox(width: 18), const Text('|', style: TextStyle(color: Colors.grey)), const SizedBox(width: 18), const Text('1,648 reviews'), const SizedBox(width: 18), const Text('|', style: TextStyle(color: Colors.grey)), const SizedBox(width: 18), const Text('OCT 24–26')]),
        const SizedBox(height: 28), Row(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.location_on_outlined)), const SizedBox(width: 16), const Expanded(child: Text('1155 Rue Sherbrooke Ouest, Toronto, Canada H3A 2N3', style: TextStyle(color: Colors.grey, fontSize: 16)))]),
      ]))),
      Padding(padding: const EdgeInsets.fromLTRB(28, 26, 28, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), const SizedBox(height: 12), Text(destination.description.isEmpty ? 'A memorable escape with thoughtful amenities, beautiful surroundings, and everything you need for a relaxed stay.' : destination.description, style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1.5)), const SizedBox(height: 24), SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Get.toNamed(AppRoutes.booking), child: const Text('Book this stay')))])),
    ]))));
  }
}
