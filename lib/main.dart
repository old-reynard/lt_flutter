import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_things/auth/services/auth.dart';
import 'package:little_things/meta/app.dart';
import 'package:logging/logging.dart';

void log(LogRecord record) => print('${record.level.name}: ${record.time}: ${record.message}');

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance!.resamplingEnabled = true;

  await initFirebase();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(log);


  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const LittleThings());
}
