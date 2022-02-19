import 'package:flutter/material.dart';
import 'package:little_things/meta/widgets/image.dart';
import 'package:little_things/meta/widgets/visual.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double radius;

  const Avatar({
    Key? key,
    required this.url,
    this.radius = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: NetworkImager(
        url,
      ).crop(all: radius),
    );
  }
}
