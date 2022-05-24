import 'dart:collection';
import 'dart:math';

import 'package:SmashUp/domain/entity/player_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base_screen.dart';
import '../../domain/entity/fraction_entity.dart';
import '../../util/app_locale.dart';

class CreatedFractionScreen extends BaseScreen {
  Map<List<PlayerEntity>, List<FractionEntity>> arg;

  CreatedFractionScreen({required this.arg})
      : super(_CreatedFractionScreen(
            fraction: arg.values.first, players: arg.keys.first));
}

class _CreatedFractionScreen extends BaseState<CreatedFractionScreen> {
  List<PlayerEntity> players;
  List<FractionEntity> fraction;

  List<_UserWithFraction> data = [];

  _CreatedFractionScreen({required this.fraction, required this.players});

  @override
  void initState() {
    data = createRandomList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)?.create_game ?? "")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(height: 20, width: 20);
          } else if (index == data.length + 1) {
            return SizedBox(height: 20, width: 20);
          } else {
            _UserWithFraction item = data[index - 1];
            return Container(
              color: item.color,
              padding: EdgeInsets.all(10),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(children: [
                              Text(item.name,
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.white,
                                  )),
                              Text(item.name)
                            ])
                          ]),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              item.firstFraction.getAssetImage(),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 20, width: 20),
                            Stack(
                              children: [
                                Text(
                                  item.firstFraction.getLocalizedName(
                                      AppLocale.instance.current),
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(item.firstFraction.getLocalizedName(
                                    AppLocale.instance.current))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              item.secondFraction.getAssetImage(),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 20, width: 20),
                            Stack(
                              children: [
                                Text(
                                  item.secondFraction.getLocalizedName(
                                      AppLocale.instance.current),
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(item.secondFraction.getLocalizedName(
                                    AppLocale.instance.current))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
        itemCount: data.length + 2,
      ),
    );
  }

  List<_UserWithFraction> createRandomList() {
    List<_UserWithFraction> resultList = [];
    LinkedList<FractionEntry> localFraction = LinkedList();

    localFraction.addAll(fraction.map((e) => FractionEntry.fromEntry(e)));
    int index = 0;

    while (resultList.length < players.length) {
      FractionEntry firstFraction = getRandomFraction(localFraction);
      localFraction.remove(firstFraction);
      FractionEntry secondFraction = getRandomFraction(localFraction);
      localFraction.remove(secondFraction);

      resultList.add(_UserWithFraction(
          name: players[index].name,
          color: players[index].color,
          firstFraction: FractionEntity.fromEntry(firstFraction),
          secondFraction: FractionEntity.fromEntry(secondFraction)));
      index++;
    }

    return resultList;
  }

  FractionEntry getRandomFraction(LinkedList<FractionEntry> data) {
    return data.elementAt(Random.secure().nextInt(data.length));
  }

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

class _UserWithFraction {
  String name;
  FractionEntity firstFraction;
  FractionEntity secondFraction;
  Color color;

  _UserWithFraction(
      {required this.name,
      required this.secondFraction,
      required this.firstFraction,
      required this.color});
}
