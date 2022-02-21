import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_things/auth/models/seeker.dart';
import 'package:little_things/meta/models/json.dart';
import 'package:quiver/core.dart';

class PinCategory {
  final int id;
  final String name;
  final String? asset;
  final DateTime? created;

  PinCategory({
    required this.id,
    required this.name,
    this.asset,
    this.created,
  });

  factory PinCategory.fromJson(Json? json) {
    if (json == null || json.isEmpty) return PinCategory.empty();
    return PinCategory(
      id: json['id'],
      name: json['name'],
      asset: json['asset'],
      created: DateTime.tryParse(json['created'] ?? ''),
    );
  }

  factory PinCategory.empty() {
    return PinCategory(id: 0, name: '');
  }

  @override
  String toString() {
    return 'Category #$id - $name';
  }

  @override
  bool operator ==(Object other) {
    return other is PinCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  bool get isEmpty => id == 0 && name == '';
}

abstract class Drop {
  final double latitude;
  final double longitude;

  Marker toMarker({VoidCallback? onTap});

  Drop(this.latitude, this.longitude);

  LatLng get position => LatLng(latitude, longitude);
}

class PinSketch extends Drop {
  final category = ValueNotifier<PinCategory>(PinCategory.empty());
  final description = ValueNotifier<String>('');

  PinSketch({
    required double latitude,
    required double longitude,
    // PinCategory? category,
  }) : super(latitude, longitude);

  @override
  String toString() {
    return 'PinSketch at ($latitude, $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return other is Drop && other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => hash2(latitude.hashCode, longitude.hashCode);

  @override
  Marker toMarker({VoidCallback? onTap}) {
    return Marker(
      position: position,
      markerId: MarkerId('$latitude,$longitude'),
      onTap: onTap,
    );
  }

  Json toJson() {
    Json json = {
      'latitude': latitude,
      'longitude': longitude,
      'description': description.value,
    };

    if (!category.value.isEmpty) json['category'] = category.value.id;
    return json;
  }
}

class Pin extends Drop {
  final int? id;
  final Seeker by;
  final int? votedByMe;
  final String? description;
  final PinCategory? category;
  final int notes;
  final int approves;
  final int disapproves;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // final String? displayNote;

  Pin({
    this.id,
    required double latitude,
    required double longitude,
    this.category,
    required this.by,
    this.votedByMe,
    this.description,
    this.notes = 0,
    this.approves = 0,
    this.disapproves = 0,
    // this.displayNote,
    this.createdAt,
    this.updatedAt,
  }) : super(latitude, longitude);

  factory Pin.fromJson(Json json) {
    return Pin(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      category: PinCategory.fromJson(json['category']),
      by: Seeker.fromJson(json['by']),
      votedByMe: json['votedByMe'],
      description: json['description'],
      notes: json['notes'],
      approves: json['approves'],
      disapproves: json['disapproves'],
      createdAt: DateTime.tryParse(json['createdAt']),
      updatedAt: DateTime.tryParse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return '${category?.name ?? "Pin"} at ($latitude, $longitude)';
  }

  @override
  Marker toMarker({VoidCallback? onTap}) {
    return Marker(
      markerId: MarkerId('$id'),
      position: position,
      onTap: onTap,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Pin && other.id == id;
  }

  bool get isUnsaved => id == null;

  @override
  int get hashCode => id.hashCode;
}
