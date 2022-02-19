import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension Helpers on Widget {
  Widget ink({VoidCallback? onTap}) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: this,
      ),
    );
  }

  Widget pad({
    double top = .0,
    double bottom = .0,
    double left = .0,
    double right = .0,
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    if (all != null) {
      return Padding(
        padding: EdgeInsets.all(all),
        child: this,
      );
    }

    if (horizontal != null || vertical != null) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? .0,
          vertical: vertical ?? .0,
        ),
        child: this,
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget crop({
    double? all,
    double tl = 0.0,
    double tr = 0.0,
    double bl = 0.0,
    double br = 0.0,
  }) {
    if (all != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(all),
        child: this,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(tl),
        topRight: Radius.circular(tr),
        bottomLeft: Radius.circular(bl),
        bottomRight: Radius.circular(br),
      ),
      child: this,
    );
  }
}

Widget space([double height = 16]) {
  return SizedBox(height: height);
}

/// utility that renders SVG images
Widget vector(String asset, {double? height, double? width, BoxFit fit = BoxFit.contain, Color? color}) {
  return SvgPicture.asset(
    asset,
    width: width,
    height: height,
    fit: fit,
    color: color,
  );
}
