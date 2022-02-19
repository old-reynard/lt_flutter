import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImager extends StatelessWidget {
  final String? url;
  final bool cached;
  final BoxFit? fit;
  final Widget? loader;
  final Widget Function(BuildContext context, String url, dynamic error)? errorBuilder;

  const NetworkImager(
    this.url, {
    Key? key,
    this.cached = true,
    this.fit,
    this.loader,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cached) {
      return CachedNetworkImage(
        filterQuality: FilterQuality.medium,
        imageUrl: url!,
        fit: fit,
        placeholder: (context, url) => loader ?? Container(color: Theme.of(context).canvasColor),
        errorWidget: errorBuilder,
      );
    } else {
      return Image.network(
        url!,
        gaplessPlayback: true,
        filterQuality: FilterQuality.medium,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return loader ?? Container(color: Theme.of(context).canvasColor);
        },
        frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            child: child,
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
          );
        },
      );
    }
  }
}
