import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_things/auth/models/seeker.dart';
import 'package:little_things/map/models/map_storage.dart';
import 'package:little_things/map/models/pins.dart';
import 'package:little_things/meta/services/globals.dart';
import 'package:little_things/meta/utils/misc.dart';
import 'package:little_things/meta/utils/navigation.dart';
import 'package:little_things/meta/vectors.dart';
import 'package:little_things/meta/widgets/avatar.dart';
import 'package:little_things/meta/widgets/bottom_sheet.dart';
import 'package:little_things/meta/widgets/buttons.dart';
import 'package:little_things/meta/widgets/text.dart';
import 'package:little_things/meta/widgets/text_field.dart';
import 'package:little_things/meta/widgets/visual.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  // ignore: unused_field
  late GoogleMapController _controller;
  static const CameraPosition _initPosition = CameraPosition(
    // bearing: 192.8334901395799,
    target: LatLng(43.65, -79.3832),
    tilt: 59.440717697143555,
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _map(),
          Positioned(
            top: 0,
            right: 0,
            child: _avatar(),
          )
        ],
      ),
    );
  }

  Widget _map() {
    final storage = context.watch<MapStorage>();
    final markers = storage.all.map((drop) {
      return drop.toMarker(onTap: () {
        if (drop is PinSketch) {
          _toExistingPinSketch(drop);
        }

        if (drop is Pin) {
          _toExistingPin(drop);
        }
      });
    }).toSet();

    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      initialCameraPosition: _initPosition,
      onMapCreated: (GoogleMapController c) => _controller = c,
      onLongPress: _onLongPress,
    );
  }

  Widget _avatar() {
    final seeker = context.watch<Seeker>();
    if (seeker.isEmpty) return Container();
    return SafeArea(
      child: Avatar(
        url: seeker.picture!,
      ).pad(right: 16),
    );
  }

  Widget _categoriesDropdown(PinSketch sketch) {
    final storage = context.read<MapStorage>();
    return ValueListenableBuilder<PinCategory>(
      valueListenable: sketch.category,
      builder: (context, cat, __) {
        return DropdownButton<PinCategory>(
          value: cat.isEmpty ? null : cat,
          items: storage.categories.map((category) {
            return DropdownMenuItem<PinCategory>(
              value: category,
              child: Text(
                category.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          }).toList(),
          onChanged: (category) {
            if (category != null) {
              sketch.category.to(category);
            }
          },
        );
      },
    );
  }

  void _onLongPress(LatLng position) {
    if (!context.isLoggedIn) {
      return _toLogin();
    } else {
      return _toNewPinSketch(position);
    }
  }

  void _toLogin() {
    bottomSheet(
      context,
      height: .4,
      child: TextBuilder(
        builder: (context, l, theme) {
          return Center(
            child: Column(
              children: [
                space(),
                Text(
                  l.loginToProceed,
                  style: theme.primaryTextTheme.headline4,
                  textAlign: TextAlign.center,
                ).pad(bottom: 8),
                Text(
                  l.loginToProceedBody,
                  style: theme.primaryTextTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                space(80),
                SecondaryButton(
                  onPressed: _login,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          l.loginWithGoogle,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        top: 0,
                        right: 0,
                        child: vector(googleIcon),
                      )
                    ],
                  ),
                ).pad(horizontal: 40)
              ],
            ),
          );
        },
      ).pad(horizontal: 24),
    );
  }

  Future<void> _login() async {
    final seeker = await authService.loginWithGoogle();
    context.login(seeker);
    context.pop();
  }

  Future<void> _restartSession() async {
    authService.refresh().then(context.login);
  }

  Future<void> _initCategories() async => await MapStorage.of(context).initCategories();

  Future<void> _initPins() async => await MapStorage.of(context).initPins();

  Future<void> _init() async {
    await _restartSession();

    void _data() {
      _initCategories();
      _initPins();
    }

    if (context.isLoggedIn) {
      _data();
    } else {
      await 2.seconds; // todo change
      _data();
    }
  }

  void _toNewPinSketch(LatLng position) {
    final storage = MapStorage.of(context);
    if (!storage.isInitialized) return;

    final sketch = storage.sketch(position);
    bottomSheet(
      context,
      height: .3,
      child: TextBuilder(
        builder: (context, l, theme) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space(),
                Text(
                  l.letsMarkOnMap,
                  style: theme.primaryTextTheme.headline4,
                  textAlign: TextAlign.center,
                ).pad(bottom: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l.whatCategory,
                      style: theme.textTheme.bodyText1,
                    ),
                    _categoriesDropdown(sketch),
                  ],
                ),
                Text(
                  l.usefulHints,
                  style: theme.textTheme.bodyText1,
                ),
                PrimaryTextField(
                  maxLines: 3,
                  autoFocus: false,
                  onChanged: sketch.description.to,
                  initValue: sketch.description.value,
                ),
                space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder<PinCategory>(
                        valueListenable: sketch.category,
                        builder: (context, category, _) {
                          final callback = category.isEmpty ? null : () => _saveSketch(sketch);
                          return PrimaryMinuteButton(
                            child: Text(l.save),
                            onPressed: callback,
                          );
                        }),
                  ],
                ),
              ],
            ),
          );
        },
      ).pad(horizontal: 24),
    );
  }

  void _toExistingPinSketch(PinSketch sketch) {
    bottomSheet(
      context,
      height: .4,
      child: TextBuilder(
        builder: (context, l, theme) {
          return Center(
            child: Column(
              children: [
                space(),
                Text(
                  l.letsMarkOnMap,
                  style: theme.primaryTextTheme.headline4,
                  textAlign: TextAlign.center,
                ).pad(bottom: 8),
                _categoriesDropdown(sketch),
              ],
            ),
          );
        },
      ).pad(horizontal: 24),
    );
  }

  void _toExistingPin(Pin pin) {
    bottomSheet(
      context,
      height: .4,
      child: TextBuilder(
        builder: (context, l, theme) {
          return Center(
            child: Column(
              children: [
                space(),
                Text(
                  pin.category!.name,
                  style: theme.primaryTextTheme.headline4,
                  textAlign: TextAlign.center,
                ).pad(bottom: 8),
              ],
            ),
          );
        },
      ).pad(horizontal: 24),
    );
  }

  Future<void> _saveSketch(PinSketch sketch) async {
    await MapStorage.of(context).createPin(sketch);
    context.pop();
  }
}

extension on num {
  Future<void> get seconds => Future.delayed(Duration(milliseconds: (this * 1000).round()));
}
