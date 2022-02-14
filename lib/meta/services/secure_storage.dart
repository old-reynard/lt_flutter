import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service that allows to securely store smaller amounts of data
/// on the device
const _storage = FlutterSecureStorage();

const _themeKey = 'theme';

Future<void> storeTheme(String name) async {
  await _storage.write(key: _themeKey, value: name);
}

Future<String?> getStoredTheme() {
  return _storage.read(key: _themeKey);
}
