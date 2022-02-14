import 'package:flutter/material.dart';
import 'package:little_things/meta/services/secure_storage.dart';
import 'package:little_things/meta/theme/dark.dart';
import 'package:little_things/meta/theme/light.dart';

const _lightThemeName = 'light';
const _darkThemeName = 'dark';
const _automaticThemeName = 'automatic';

/// listenable structure that controls
/// the current theme of the entire app
final themeSwitcher = ValueNotifier<AppTheme>(_light);

extension Themes on ValueNotifier<AppTheme> {
  void load(AppTheme theme) => value = theme;

  void loadLightTheme() {
    load(_light);
    storeTheme(_lightThemeName);
  }

  void loadDarkTheme() {
    load(_dark);
    storeTheme(_darkThemeName);
  }

  void loadAutomaticTheme(BuildContext context) {
    if (context.isDarkMode) {
      load(AppTheme(_automaticThemeName, darkThemeData));
    }

    if (context.isLightMode) {
      load(AppTheme(_automaticThemeName, lightThemeData));
    }

    storeTheme(_automaticThemeName);
  }

  bool get isLight => value.name == _lightThemeName;

  bool get isDark => value.name == _darkThemeName;

  bool get isAutomatic => value.name == _automaticThemeName;

  Future<void> _resolve(BuildContext context, String? name) async {
    switch (name) {
      case _darkThemeName:
        loadDarkTheme();
        break;
      case _lightThemeName:
        loadLightTheme();
        break;
      case _automaticThemeName:
        loadAutomaticTheme(context);
        break;
      default:
        loadLightTheme();
    }
  }

  Future<void> resolvePredefinedTheme(BuildContext context) async {
    final storedThemeName = await getStoredTheme();
    await themeSwitcher._resolve(context, storedThemeName);
  }
}

final _light = AppTheme(_lightThemeName, lightThemeData);
final _dark = AppTheme(_darkThemeName, darkThemeData);

/// container that will allow to tag different app themes
class AppTheme {
  final String name;
  final ThemeData theme;

  const AppTheme(this.name, this.theme);

  @override
  bool operator ==(Object other) {
    return other is AppTheme && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

extension on BuildContext {
  bool get isDarkMode => MediaQuery.of(this).platformBrightness == Brightness.dark;

  bool get isLightMode => MediaQuery.of(this).platformBrightness == Brightness.light;
}
