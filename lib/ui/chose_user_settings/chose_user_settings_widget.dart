import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entity/player_entity.dart';

class ChoseUserSettingsWidget extends StatefulWidget {
  List<PlayerEntity> defaultPlayers;
  Function newUserData;

  ChoseUserSettingsWidget(
      {required this.defaultPlayers, required this.newUserData});

  @override
  State<StatefulWidget> createState() => _ChoseUserSettingsState();
}

class _ChoseUserSettingsState extends State<ChoseUserSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                PlayerEntity item = widget.defaultPlayers[index];
                TextEditingController textController = TextEditingController();
                textController.text = item.name;

                return SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                item.name = value;
                              }
                            },
                            controller: textController,
                          )),
                      InkWell(
                        onTap: () {
                          Color? pickColor;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(AppLocalizations.of(context)
                                      ?.customization_user ??
                                      ""),
                                  content: ColorPicker(
                                    pickerColor: item.color,
                                    onColorChanged: (Color value) {
                                      pickColor = value;
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          if (pickColor != null) {
                                            print(pickColor);
                                            item.color = pickColor!;
                                            setState(() {});
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Text(AppLocalizations.of(context)
                                            ?.apply ??
                                            ""))
                                  ],
                                );
                              });
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          color: item.color,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.defaultPlayers.length,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                widget.newUserData(widget.defaultPlayers);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)?.apply ?? ""))
        ],
      ),
    );
  }
}
