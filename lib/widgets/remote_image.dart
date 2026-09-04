import 'package:flutter/material.dart';

class RemoteImage extends StatelessWidget {
  const RemoteImage({super.key, required this.url, this.fit = BoxFit.cover, this.borderRadius});
  final String url;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.network(url, fit: fit, errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey.shade900, child: const Icon(Icons.image_outlined, color: Colors.white54, size: 42))),
      );
}

class RemoteAvatar extends StatelessWidget {
  const RemoteAvatar({super.key, required this.url, required this.radius});
  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.blueGrey.shade800,
        child: ClipOval(child: SizedBox(width: radius * 2, height: radius * 2, child: RemoteImage(url: url))),
      );
}
