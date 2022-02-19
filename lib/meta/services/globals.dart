import 'dart:ui' as ui;

import 'package:little_things/auth/services/auth.dart';
import 'package:little_things/map/services/map_service.dart';

typedef Headers = Map<String, String>;

Headers _informationalHeaders() {
  Map<String, String> headers = {};

  headers['content-type'] = "application/json";
  headers['X-App-Lang'] = '${ui.window.locale.languageCode}-${ui.window.locale.countryCode}';

  return headers;
}

final authService = AuthService();
final mapService = MapService();

Headers get requestHeaders {
  return {}
    ..addAll(_informationalHeaders())
    ..addAll(authService.authHeader());
}
