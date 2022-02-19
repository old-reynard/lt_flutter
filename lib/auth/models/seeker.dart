import 'package:flutter/material.dart';
import 'package:little_things/meta/models/json.dart';
import 'package:provider/provider.dart';

class Seeker with ChangeNotifier {
  String? name;
  String? picture;
  String? userId;
  String? email;
  bool verified;
  DateTime? created;
  String? token;

  Seeker({
    this.name,
    this.picture,
    this.userId,
    this.email,
    this.verified = false,
    this.created,
    this.token,
  });

  factory Seeker.fromJson(Json json) {
    if (json.isEmpty) return Seeker.empty();
    return Seeker(
      name: json['name'],
      picture: json['avatar'],
      userId: json['id'],
      email: json['email'],
      token: json['token'],
      verified: json['verified'] ?? false,
      created: DateTime.tryParse(json['created'] ?? ''),
    );
  }

  static Seeker of(BuildContext context) => Provider.of<Seeker>(context, listen: false);

  factory Seeker.empty() {
    return Seeker();
  }

  void replace(Seeker other) {
    name = other.name;
    picture = other.picture;
    userId = other.userId;
    email = other.email;
    verified = other.verified;
    created = other.created;
    token = other.token;

    notifyListeners();
  }

  bool get isEmpty => userId == null;

  @override
  String toString() {
    if (isEmpty) return 'Anonymous seeker';
    return 'Seeker #$userId, $name';
  }
}

extension SeekerContext on BuildContext {
  bool get isLoggedIn => !Seeker.of(this).isEmpty;

  void login(Seeker other) {
    Seeker.of(this).replace(other);
  }
}
