import 'package:flutter/material.dart';

extension ContextNavigation on BuildContext {
  void pop() => Navigator.of(this).pop();
}