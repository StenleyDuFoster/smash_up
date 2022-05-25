import 'dart:ui';

import 'fraction_entity.dart';

class PlayerWithFraction {
  String name;
  FractionEntity firstFraction;
  FractionEntity secondFraction;
  Color color;

  PlayerWithFraction(
      {required this.name,
        required this.secondFraction,
        required this.firstFraction,
        required this.color});
}
