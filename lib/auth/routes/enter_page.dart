import 'package:flutter/material.dart';
import 'package:little_things/meta/services/globals.dart' show authService;

class EnterPage extends StatelessWidget {
  const EnterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final user = await authService.loginWithGoogle();
            var a = 1;
            print(user);
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
