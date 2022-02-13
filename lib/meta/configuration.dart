class Configuration {
  static const String appName = String.fromEnvironment('LT_APP_NAME');
  static const String environment = String.fromEnvironment('LT_ENVIRONMENT');
  static const String apiUrl = 'https://${const String.fromEnvironment('LT_API_URL')}';
  static const String mapsApiKey = String.fromEnvironment('LT_MAPS_API_KEY');
  static const String bundleSuffix = String.fromEnvironment('LT_BUNDLE_SUFFIX');
}
