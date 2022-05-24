import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base_screen.dart';
import '../../domain/entity/fraction_entity.dart';

class CreatedFractionScreen extends BaseScreen {
  Map<int, List<FractionEntity>> arg;

  CreatedFractionScreen({required this.arg})
      : super(_CreatedFractionScreen(
            fraction: arg.values.first, playerCount: arg.keys.first));
}

class _CreatedFractionScreen extends BaseState<CreatedFractionScreen> {
  int playerCount;
  List<FractionEntity> fraction;

  List<_UserWithFraction> data = [];

  _CreatedFractionScreen({required this.fraction, required this.playerCount});

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
            return Column(
              children: [
                Text(item.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item.firstFraction.getAssetImage(),
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 20, width: 20),
                    Text(item.firstFraction.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item.secondFraction.getAssetImage(),
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 20, width: 20),
                    Text(item.secondFraction.name)
                  ],
                )
              ],
            );
          }
        },
        itemCount: data.length + 2,
      ),
    );
  }

  List<_UserWithFraction> createRandomList() {
    List<_UserWithFraction> resultList = [];
    List<FractionEntity> localFraction = [];

    localFraction.addAll(fraction);
    int index = 0;

    while (resultList.length < playerCount) {
      index++;
      FractionEntity firstFraction = getRandomFraction(localFraction);
      localFraction.remove(firstFraction);
      FractionEntity secondFraction = getRandomFraction(localFraction);
      localFraction.remove(secondFraction);

      resultList.add(_UserWithFraction(
          name: "Player " + index.toString(),
          firstFraction: firstFraction,
          secondFraction: secondFraction));
    }

    return resultList;
  }

  FractionEntity getRandomFraction(List<FractionEntity> data) {
    return data[Random.secure().nextInt(data.length)];
  }
}

class _UserWithFraction {
  String name;
  FractionEntity firstFraction;
  FractionEntity secondFraction;

  _UserWithFraction(
      {required this.name,
      required this.secondFraction,
      required this.firstFraction});
}
