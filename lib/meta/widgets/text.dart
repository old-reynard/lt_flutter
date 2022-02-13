import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef ThemeWidgetBuilder = Widget Function(BuildContext context, ThemeData theme);
typedef LocaleWidgetBuilder = Widget Function(BuildContext context, AppLocalizations l);
typedef TextWidgetBuilder = Widget Function(BuildContext context, AppLocalizations l, ThemeData theme);

class ThemeBuilder extends StatelessWidget {
  final ThemeWidgetBuilder builder;

  const ThemeBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) => builder(context, Theme.of(context));
}

class LocaleBuilder extends StatelessWidget {
  final LocaleWidgetBuilder builder;

  const LocaleBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) => builder(context, AppLocalizations.of(context)!);
}

class TextBuilder extends StatelessWidget {
  final TextWidgetBuilder builder;

  const TextBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, AppLocalizations.of(context)!, Theme.of(context));
  }
}
