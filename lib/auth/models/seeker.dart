import 'package:little_things/meta/models/json.dart';

class Seeker {
  final String? name;
  final String? picture;
  final String? userId;
  final String? email;
  final bool verified;
  final DateTime? created;
  final String? token;

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

  factory Seeker.empty() {
    return Seeker();
  }

  bool get isEmpty => userId == null;

  @override
  String toString() {
    if (isEmpty) return 'Anonymous seeker';
    return 'Seeker #$userId, $name';
  }
}
