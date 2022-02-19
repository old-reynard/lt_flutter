import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_things/auth/models/seeker.dart';
import 'package:little_things/meta/models/json.dart';

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
}

class Pin {
  final int id;
  final double latitude;
  final double longitude;
  final PinCategory? category;
  final Seeker by;
  final int? votedByMe;
  final String? description;
  final int notes;
  final int approves;
  final int disapproves;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // final String? displayNote;

  Pin({
    required this.id,
    required this.latitude,
    required this.longitude,
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
  });

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

  Marker toMarker() {
    return Marker(
      markerId: MarkerId('$id'),
      position: LatLng(latitude, longitude),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Pin && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
