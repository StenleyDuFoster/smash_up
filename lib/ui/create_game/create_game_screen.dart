import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smash_up/core/base_screen.dart';
import 'package:smash_up/navigation/nav_const.dart';
import 'package:smash_up/ui/chose_fraction/ChoseFractionDialog.dart';

import '../../domain/entity/fraction_entity.dart';

class CreateGameScreen extends BaseScreen {
  CreateGameScreen() : super(_CreateGameScreen());
}

class _CreateGameScreen extends BaseState<CreateGameScreen> {
  String inputText = "";
  List<FractionEntity> fraction = [];

  bool _isInputValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)?.create_game ?? "")),
      body: Container(
        padding: EdgeInsets.all(50),
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
                      AppLocalizations.of(context)?.enter_player_count ?? ""),
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
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                            (AppLocalizations.of(context)?.select_fraction ??
                                    "") + "(" + fraction.length.toString() + ")"))),
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
                          title: Text(
                              AppLocalizations.of(context)?.select_fraction ??
                                  ""),
                        );
                      });
                },
              ),
            ),
            Spacer(),
            Visibility(
              visible: _isInputValid,
              child: Card(
                child: InkWell(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                              AppLocalizations.of(context)?.create_game ??
                                  ""))),
                  onTap: () {
                    Navigator.pushNamed(context, Screen.CreatedFraction.name);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 20
        ? TextEditingValue().copyWith(text: '20')
        : newValue;
  }
}
