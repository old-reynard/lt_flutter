import 'package:flutter/material.dart';

Future<T?> bottomSheet<T>(
  BuildContext context, {
  required Widget child,
  double height = .5,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * height,
        child: child,
      );
    },
  );
}
