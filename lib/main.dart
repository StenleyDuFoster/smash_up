import 'dart:async';

import 'package:SmashUp/data/local/fraction_singletone.dart';
import 'package:SmashUp/ui/start_screen/start_screen.dart';
import 'package:SmashUp/util/app_locale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/local/preferences.dart';
import 'domain/db_model/fraction_db_model.dart';
import 'firebase_options.dart';
import 'navigation/nav_const.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Fraction.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Object? data;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          data = snapshot.data;
          return _LocalizedApp((snapshot.data as List<dynamic>).last as Locale);
        } else if (data != null) {
          return _LocalizedApp((data as List<dynamic>).last as Locale);
        }
        return Container(
          child: Center(child: CircularProgressIndicator.adaptive()),
        );
      },
      future: Future.wait([
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        Hive.initFlutter().then((value) {
          Hive.registerAdapter(FractionDbModelAdapter());
        }),
        PreferencesManager.instance.getLocale()
      ]),
    );
  }

}

class _LocalizedApp extends StatefulWidget {

  Locale? _currentLocale;

  _LocalizedApp(Locale locale) {
    _currentLocale = locale;
    AppLocale.instance.setLocale(locale);
  }

  @override
  State<StatefulWidget> createState() => LocalizedAppState();
}
class LocalizedAppState extends State<_LocalizedApp> {

  @override
  void initState() {
    AppLocale.instance.localeStream().listen((event) {
      if (event.languageCode == widget._currentLocale!.languageCode) {
        return;
      }
      widget._currentLocale = event;
      setState(() {

      });
    });
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>  MaterialApp(
    title: 'Smash Up',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: StartScreen(),
    locale: widget._currentLocale,
    routes: {
      Screen.Start.name: (BuildContext context) =>
          Screen.Start.screen(ModalRoute.of(context)?.settings.arguments),
      Screen.CreateGame.name: (BuildContext context) =>
          Screen.CreateGame.screen(
              ModalRoute.of(context)?.settings.arguments),
      Screen.CreatedFraction.name: (BuildContext context) =>
          Screen.CreatedFraction.screen(
              ModalRoute.of(context)?.settings.arguments),
      Screen.ViewFraction.name: (BuildContext context) =>
          Screen.ViewFraction.screen(
              ModalRoute.of(context)?.settings.arguments),
    },
  );

}
