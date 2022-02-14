import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:little_things/map/routes/map_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:little_things/meta/theme/index.dart';

class LittleThings extends StatelessWidget {
  const LittleThings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
        valueListenable: themeSwitcher,
        builder: (context, appTheme, _) {
          themeSwitcher.resolvePredefinedTheme(context);

          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: appTheme.theme,
            home: const MapPage(),
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
