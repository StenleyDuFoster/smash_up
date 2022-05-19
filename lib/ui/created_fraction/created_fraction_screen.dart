import 'package:flutter/material.dart';
import 'package:smash_up/core/base_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatedFractionScreen extends BaseScreen {
  CreatedFractionScreen() : super(_CreatedFractionScreen());
}

class _CreatedFractionScreen extends BaseState<CreatedFractionScreen> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text(AppLocalizations.of(context)?.create_game ?? "")),
   );
  }

}
