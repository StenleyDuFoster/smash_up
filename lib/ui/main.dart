import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_up/ui/start_screen/start_screen.dart';

import '../domain/db_model/fraction_db_model.dart';
import '../firebase_options.dart';
import '../navigation/nav_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildApp();
        }
        return Container(child: Center(child:CircularProgressIndicator.adaptive()),);
      },
      future: Future.wait([
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        Hive.initFlutter().then((value) {
          Hive.registerAdapter(FractionDbModelAdapter());
        })
      ]),
    );
  }

  Widget _buildApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', ''),
        // Locale('ua', ''),
      ],
      home: StartScreen(),
      routes: {
        Screen.Start.name: (BuildContext context) => Screen.Start.screen(ModalRoute.of(context)?.settings.arguments),
        Screen.CreateGame.name: (BuildContext context) =>
            Screen.CreateGame.screen(ModalRoute.of(context)?.settings.arguments),
        Screen.CreatedFraction.name: (BuildContext context) =>
            Screen.CreatedFraction.screen(ModalRoute.of(context)?.settings.arguments),
        Screen.ViewFraction.name: (BuildContext context) =>
            Screen.ViewFraction.screen(ModalRoute.of(context)?.settings.arguments),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
