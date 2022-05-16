import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/base_screen.dart';

class StartScreen extends BaseScreen {
  StartScreen() : super(_StartScreen());
}

class _StartScreen extends BaseState<StartScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
    );
  }

}
