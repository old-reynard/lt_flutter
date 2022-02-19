import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:little_things/auth/models/seeker.dart';
import 'package:little_things/meta/configuration.dart';
import 'package:little_things/meta/services/network_service.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp();
}

class AuthService {
  final _firebase = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: []);
  final _api = Configuration.apiUrl;
  final _service = 'AuthService';

  Future<User?> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _firebase.signInWithCredential(credential);
      final user = authResult.user;

      return user;
    } catch (error) {
      if (error is PlatformException) {
        print(error.details);
        print(error.code);
        print(error.message);
      }
      return null;
    }
  }

  Future<Seeker> _reportToken(String token) async {
    final headers = {'Authorization': token};
    final url = '$_api/sso';
    final bundle = NetworkBundle(
      url,
      verb: 'post',
      method: 'loginWithGoogle',
      headers: headers,
      service: _service,
      body: {},
    );
    final response = await request(bundle);
    return Seeker.fromJson(response.body['user']);
  }

  Future<Seeker> loginWithGoogle() async {
    final _ssoUser = await _loginWithGoogle();
    if (_ssoUser == null) {
      throw UnauthorizedError();
    }
    final token = await _ssoUser.getIdToken();
    return _reportToken(token);
  }

  User? currentUser() {
    return _firebase.currentUser;
  }

  Future<Seeker> refresh() async {
    final user = _firebase.currentUser;
    if (user == null) Seeker.empty();
    return _reportToken(await user!.getIdToken(true));
  }
}
