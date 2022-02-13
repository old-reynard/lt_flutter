import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:little_things/auth/routes/enter_page.dart';
import 'package:little_things/map/routes/map_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LittleThings extends StatelessWidget {
  const LittleThings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // home: const MapPage(),
      home: const EnterPage(),
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
