import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {

  PreferencesManager._privateConstructor();
  static PreferencesManager? _instance;

  static PreferencesManager get instance {
    PreferencesManager? localInstance = _instance;
    if (localInstance != null) {
      return localInstance;
    } else {
      PreferencesManager newInstance = PreferencesManager._privateConstructor();
      _instance = newInstance;
      return newInstance;
    }
  }

  final String langKey = "lankKey";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future saveLocale(Locale locale) async {
    await (await _prefs).setString(langKey, locale.languageCode);
  }

  Future<Locale> getLocale() async {
    return Locale(await(await _prefs).getString(langKey) ?? "en");
  }

}