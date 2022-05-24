import 'dart:async';
import 'dart:ui';

import '../data/local/preferences.dart';

class AppLocale {
  AppLocale._privateConstructor();

  static AppLocale? _instance;

  static AppLocale get instance {
    AppLocale? localInstance = _instance;
    if (localInstance != null) {
      return localInstance;
    } else {
      AppLocale newInstance = AppLocale._privateConstructor();
      _instance = newInstance;
      return newInstance;
    }
  }

  Locale _current = Locale("en", "");
  StreamController<Locale> _streamController = StreamController.broadcast();

  Stream<Locale> localeStream() => _streamController.stream;

  Locale get current => _current;

  void setLocale(Locale locale) {
    _current = locale;
    _streamController.add(locale);
    PreferencesManager.instance.saveLocale(locale);
  }
}
