import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/destination.dart';
import '../routes/app_routes.dart';
import 'remote_image.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination, required this.index});
  final Destination destination;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.detail, arguments: index),
      child: Container(
        height: 425,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(children: [
            Positioned.fill(child: RemoteImage(url: destination.imageUrl)),
            Align(alignment: Alignment.bottomCenter, child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 26),
            decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1E1E20) : Colors.white, borderRadius: BorderRadius.circular(32)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(destination.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 22),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _meta('Distance', destination.distance), _meta('Available', destination.available), _meta('Price', destination.price),
              ]),
            ]),
          )),
          ]),
        ),
      ),
    );
  }

  Widget _meta(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Colors.grey)), const SizedBox(height: 7), Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))]);
}
