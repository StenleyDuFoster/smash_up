import 'dart:collection';
import 'dart:math';

import 'package:SmashUp/domain/entity/player_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base_screen.dart';
import '../../domain/entity/fraction_entity.dart';
import '../../domain/entity/player_with_fraction.dart';
import '../../util/app_locale.dart';

class CreatedFractionScreen extends BaseScreen {
  Map<List<PlayerEntity>, List<FractionEntity>>? arg;

  CreatedFractionScreen({required this.arg})
      : super(_CreatedFractionScreen(
            fraction: arg?.values?.first ?? List.empty(),
            players: arg?.keys?.first ?? List.empty()));
}

class _CreatedFractionScreen extends BaseState<CreatedFractionScreen> {
  List<PlayerEntity> players;
  List<FractionEntity> fraction;

  List<PlayerWithFraction> data = [];

  _CreatedFractionScreen({required this.fraction, required this.players});

  @override
  void initState() {
    data = createRandomList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((players.isEmpty || fraction.isEmpty) ||
        fraction.length < players.length * 2) {

      return Scaffold(
        body: InkWell(
          child: Container(
            child: Center(
              child: Text(AppLocalizations.of(context)?.something_went_wrong ?? ""),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            BackButton(),
            Expanded(
                child: Text(AppLocalizations.of(context)?.create_game ?? "")),
            InkWell(
              child: Icon(Icons.share),
              onTap: () {},
            )
          ]),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(height: 20, width: 20);
            } else if (index == data.length + 1) {
              return SizedBox(height: 20, width: 20);
            } else {
              return _createItem(context, index);
            }
          },
          itemCount: data.length + 2, // list with start and end padding
        ),
      );
    }
  }

  List<PlayerWithFraction> createRandomList() {
    List<PlayerWithFraction> resultList = [];
    LinkedList<FractionEntry> localFraction = LinkedList();

    localFraction.addAll(fraction.map((e) => FractionEntry.fromEntry(e)));
    int index = 0;

    while (resultList.length < players.length) {
      FractionEntry firstFraction = getRandomFraction(localFraction);
      localFraction.remove(firstFraction);
      FractionEntry secondFraction = getRandomFraction(localFraction);
      localFraction.remove(secondFraction);

      resultList.add(PlayerWithFraction(
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

  Widget _createItem(BuildContext context, int index) {
    PlayerWithFraction item = data[index - 1];
    return Container(
      color: item.color,
      padding: EdgeInsets.all(10),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              _createIconWithText(item, true),
              _createIconWithText(item, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createIconWithText(PlayerWithFraction item, bool isFirstFraction) {
    FractionEntity fraction =
        (isFirstFraction ? item.firstFraction : item.secondFraction);
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            fraction.getAssetImage(),
            width: 50,
            height: 50,
          ),
          SizedBox(height: 20, width: 20),
          Stack(
            children: [
              Text(
                fraction.getLocalizedName(AppLocale.instance.current),
                style: TextStyle(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(fraction.getLocalizedName(AppLocale.instance.current))
            ],
          )
        ],
      ),
    );
  }
}
