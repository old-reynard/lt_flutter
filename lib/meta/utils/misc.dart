import 'package:flutter/foundation.dart';

extension ExtendedValueNotifier on ValueNotifier {
  void to<T>(T t) => value = t;
}

extension ExtendedBooleanNotifier on ValueNotifier<bool> {
  void go() => value = true;

  void stop() => value = false;

  void flip() => value = !value;

  Future<void> wrap(AsyncCallback callback) async {
    go();
    await callback.call();
    stop();
  }
}
