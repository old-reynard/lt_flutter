import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_things/map/models/pins.dart';
import 'package:little_things/meta/services/globals.dart';
import 'package:provider/provider.dart';

class MapStorage with ChangeNotifier {
  final List<PinCategory> _categories = [];
  final List<Pin> _pins = [];
  final List<PinSketch> _sketches = [];

  bool isInitialized = false;

  Set<Drop> get all => {}
    ..addAll(_pins)
    ..addAll(_sketches);

  List<PinCategory> get categories => _categories;

  static MapStorage of(context) => Provider.of<MapStorage>(context, listen: false);

  Future<void> initCategories() async {
    if (_categories.isEmpty) {
      final categories = await mapService.getCategories();
      _categories
        ..clear()
        ..addAll(categories);
      isInitialized = true;
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

  PinSketch sketch(LatLng position) {
    final _sketch = PinSketch(latitude: position.latitude, longitude: position.longitude);
    _sketches.add(_sketch);
    notifyListeners();
    return _sketch;
  }

  void updateCategory(PinSketch sketch, PinCategory? category) {
    _sketches.where((element) => element == sketch).forEach((element) => element.updateCategory(category));
  }
}
