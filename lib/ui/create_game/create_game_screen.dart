import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base_screen.dart';
import '../../data/local/fraction_local_db.dart';
import '../../domain/entity/fraction_entity.dart';
import '../../navigation/nav_const.dart';
import '../chose_fraction/ChoseFractionDialog.dart';

class CreateGameScreen extends BaseScreen {
  CreateGameScreen() : super(_CreateGameScreen());
}

class _CreateGameScreen extends BaseState<CreateGameScreen> {
  String inputText = "";
  List<FractionEntity> fraction = [];

  bool _isInputValid = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FractionLocalDb.instance().getPreviousSelectedFraction(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
                title: Text(AppLocalizations.of(context)?.create_game ?? "")),
            body: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (text) {
                      inputText = text;
                      _checkIsInputValid();
                    },
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)?.enter_player_count ??
                                ""),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      _CustomRangeTextInputFormatter()
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                    height: 50,
                  ),
                  Card(
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
                                    _isInputValid = fraction.isNotEmpty &&
                                        inputText.isNotEmpty;
                                  });
                                  _checkIsInputValid();
                                },
                                title: Text(AppLocalizations.of(context)
                                        ?.select_fraction ??
                                    ""),
                                oldSelected: fraction,
                              );
                            });
                      },
                    ),
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: _isInputValid ? 1 : 0,
                    child: Card(
                      child: InkWell(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)?.create_game ??
                                        ""))),
                        onTap: () {
                          if (fraction.length < int.parse(inputText) * 2) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)
                                      ?.fraction_count_must_be_beggar ??
                                  ""),
                            ));
                          } else {
                            Navigator.pushNamed(
                                context, Screen.CreatedFraction.name,
                                arguments: {int.parse(inputText): fraction});
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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

class _CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return const TextEditingValue().copyWith(text: '1');
    }

    return int.parse(newValue.text) > 20
        ? const TextEditingValue().copyWith(text: '20')
        : newValue;
  }
}
