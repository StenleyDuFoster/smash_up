import 'package:SmashUp/domain/entity/player_entity.dart';
import 'package:SmashUp/util/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base_screen.dart';
import '../../data/local/fraction_local_db.dart';
import '../../domain/entity/fraction_entity.dart';
import '../../navigation/nav_const.dart';
import '../../util/custom_text_formatter.dart';
import '../chose_fraction/chose_fraction_dialog.dart';
import '../chose_user_settings/chose_user_settings_dialog.dart';

class CreateGameScreen extends BaseScreen {
  CreateGameScreen() : super(_CreateGameScreen());
}

class _CreateGameScreen extends BaseState<CreateGameScreen> {
  String inputText = "";
  List<PlayerEntity> players = [];
  List<FractionEntity> fraction = [];

  ColorHelper colorHelper = ColorHelper();

  bool _isInputValid = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FractionLocalDb.instance().getPreviousSelectedFraction(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && fraction.isEmpty) {
            return Container(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }

          try {
            fraction = snapshot.data as List<FractionEntity>;
          } catch (e) {}

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  BackButton(),
                  Expanded(
                      child: Text(
                          AppLocalizations.of(context)?.create_game ?? "")),
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _createTextInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  _createSelectFractionCard(),
                  const SizedBox(
                    height: 20,
                  ),
                  _createCustomizeUserCard(),
                  const Spacer(),
                  _createFinishButton(),
                ],
              ),
            ),
          );
        });
  }

  Widget _createTextInput() {
    return TextField(
      onChanged: (text) {
        inputText = text;
        players = createDefaultList(context, players);
        _checkIsInputValid();
      },
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)?.enter_player_count ?? ""),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        CustomRangeTextInputFormatter()
      ],
    );
  }

  Widget _createSelectFractionCard() {
    return Card(
      child: InkWell(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Text(
                    "${AppLocalizations.of(context)?.select_fraction ?? ""}(${fraction.length})"))),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return ChoseFractionDialog(
                  selectedFractionCallback:
                      (List<FractionEntity> selectedFraction) {
                    fraction = selectedFraction;
                    setState(() {
                      _isInputValid =
                          fraction.isNotEmpty && inputText.isNotEmpty;
                    });
                    _checkIsInputValid();
                  },
                  title:
                      Text(AppLocalizations.of(context)?.select_fraction ?? ""),
                  oldSelected: fraction,
                );
              });
        },
      ),
    );
  }

  Widget _createCustomizeUserCard() {
    return AnimatedOpacity(
      opacity: players.isNotEmpty ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: Card(
        child: InkWell(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Text(
                      "${AppLocalizations.of(context)?.customization_user ?? ""}"))),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ChoseUserSettingsDialog(
                    newUserData: (List<PlayerEntity> newPlayer) {
                      players = newPlayer;
                    },
                    defaultPlayers: players,
                    title: Text(
                        AppLocalizations.of(context)?.customization_user ?? ""),
                  );
                });
          },
        ),
      ),
    );
  }

  Widget _createFinishButton() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: _isInputValid ? 1 : 0,
      child: Card(
        child: InkWell(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child:
                      Text(AppLocalizations.of(context)?.create_game ?? ""))),
          onTap: () {
            if (fraction.length < int.parse(inputText) * 2) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)
                        ?.fraction_count_must_be_beggar ??
                    ""),
              ));
            } else {
              Navigator.pushNamed(context, Screen.CreatedFraction.name,
                  arguments: {players: fraction});
            }
          },
        ),
      ),
    );
  }

  List<PlayerEntity> createDefaultList(
      BuildContext context, List<PlayerEntity> startList) {
    List<PlayerEntity> resultList = [];
    resultList.addAll(startList);
    int playerCount = 0;
    try {
      playerCount = int.parse(inputText);
    } catch (e) {}
    List<Color> colorList = colorHelper.generateRandomList(
        playerCount, resultList.map((e) => e.color).toList());

    if (resultList.length == playerCount) {
      return resultList;
    } else if (resultList.length > playerCount) {
      while (resultList.length > playerCount) {
        resultList.removeLast();
      }
      return resultList;
    } else {
      for (int i = resultList.length; i < playerCount; i++) {
        resultList.add(PlayerEntity(
            name: "${AppLocalizations.of(context)?.player ?? ""} ${i + 1}",
            color: colorList.elementAt(i)));
      }
      return resultList;
    }
  }

  void _checkIsInputValid() {
    if (fraction.isNotEmpty && inputText.isNotEmpty) {
      setState(() {
        _isInputValid = true;
      });
    } else {
      if (_isInputValid) {
        setState(() {
          _isInputValid = false;
        });
      }
    }
  }
}
