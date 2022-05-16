import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smash_up/navigation/nav_const.dart';

import '../../core/base_screen.dart';

class StartScreen extends BaseScreen {
  StartScreen() : super(_StartScreen());
}

class _StartScreen extends BaseState<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _createTopSection(),
        Spacer(),
        TextButton(
            onPressed: () =>
                {Navigator.of(context).pushNamed(Screen.ViewFraction.name)},
            child: Text(AppLocalizations.of(context)?.watch_fraction ?? "")),
        Padding(padding: EdgeInsets.all(10)),
        TextButton(
            onPressed: () =>
                {Navigator.of(context).pushNamed(Screen.CreateGame.name)},
            child: Text(AppLocalizations.of(context)?.create_game ?? "")),
        Spacer(),
        Image(
          height: MediaQuery.of(context).size.height / 5,
          image: AssetImage("assets/image/smash_up_small_logo.jpg"),
        ),
        Spacer(),
        TextButton(
            onPressed: () => {},
            child: Text(AppLocalizations.of(context)?.log_in ?? "")),
        Padding(padding: EdgeInsets.all(5)),
      ]),
    );
  }

  Widget _createTopSection() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          color: Colors.blue,
        ),
        Image(
          height: MediaQuery.of(context).size.height / 3,
          image: AssetImage("assets/image/smash_up_small_logo.jpg"),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Image(
            height: MediaQuery.of(context).size.height / 3,
            image: AssetImage("assets/image/smash_up_small_logo.jpg"),
          ),
        ),
        Center(
            child: Image(
          image: AssetImage("assets/image/smash_up_big_logo.jpeg"),
          height: MediaQuery.of(context).size.height / 3,
          width: (MediaQuery.of(context).size.height / 3) * 2.7,
          fit: BoxFit.fitWidth,
        )),
      ],
    );
  }
}
