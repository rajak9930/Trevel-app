import 'package:flutter/material.dart';

class RemoteImage extends StatelessWidget {
  const RemoteImage({super.key, required this.url, this.fit = BoxFit.cover, this.borderRadius});
  final String url;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.network(
          url,
          fit: fit,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return _ImageLoadingState(
              progress: progress.expectedTotalBytes == null
                  ? null
                  : progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!,
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.blueGrey.shade900,
            child: const Icon(
              Icons.image_outlined,
              color: Colors.white54,
              size: 42,
            ),
          ),
        ),
      );
}

class _ImageLoadingState extends StatelessWidget {
  const _ImageLoadingState({this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Colors.black.withValues(alpha: 0.12),
        child: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 2.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
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
