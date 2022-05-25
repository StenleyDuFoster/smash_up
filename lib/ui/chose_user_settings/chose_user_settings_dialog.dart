import 'package:SmashUp/domain/entity/player_entity.dart';
import 'package:flutter/material.dart';

import 'chose_user_settings_widget.dart';

class ChoseUserSettingsDialog extends AlertDialog {
  @override
  Widget title;
  List<PlayerEntity> defaultPlayers;
  Function newUserData;

  ChoseUserSettingsDialog(
      {required this.title,
      required this.defaultPlayers,
      required this.newUserData})
      : super(
            title: title,
            content: ChoseUserSettingsWidget(
              defaultPlayers: defaultPlayers,
              newUserData: newUserData,
            ));
}
