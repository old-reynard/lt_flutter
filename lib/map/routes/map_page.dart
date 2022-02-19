import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_things/auth/models/seeker.dart';
import 'package:little_things/meta/services/globals.dart';
import 'package:little_things/meta/utils/navigation.dart';
import 'package:little_things/meta/vectors.dart';
import 'package:little_things/meta/widgets/avatar.dart';
import 'package:little_things/meta/widgets/bottom_sheet.dart';
import 'package:little_things/meta/widgets/buttons.dart';
import 'package:little_things/meta/widgets/text.dart';
import 'package:little_things/meta/widgets/visual.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
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

    _restartSession();
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
    return GoogleMap(
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

  void _onLongPress(LatLng position) {
    if (!context.isLoggedIn) {
      return _toLogin();
    }
    print('logged out');
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
}
