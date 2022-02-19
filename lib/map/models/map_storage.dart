import 'package:flutter/material.dart';
import 'package:little_things/map/models/pins.dart';
import 'package:little_things/meta/services/globals.dart';
import 'package:provider/provider.dart';

class MapStorage with ChangeNotifier {
  final List<PinCategory> _categories = [];
  final List<Pin> _pins = [];

  Set<Pin> get pins => _pins.toSet();

  static MapStorage of(context) => Provider.of<MapStorage>(context, listen: false);

  Future<void> initCategories() async {
    if (_categories.isEmpty) {
      final categories = await mapService.getCategories();
      _categories
        ..clear()
        ..addAll(categories);
      notifyListeners();
    }
  }

  Future<void> initPins() async {
    if (_pins.isEmpty) {
      final pins = await mapService.getPins();
      _pins
        ..clear()
        ..addAll(pins);
      notifyListeners();
    }
  }
}
