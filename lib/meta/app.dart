import 'package:flutter/material.dart';
import 'package:little_things/map/routes/map_page.dart';

class LittleThings extends StatelessWidget {
  const LittleThings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MapPage(),
    );
  }
}
