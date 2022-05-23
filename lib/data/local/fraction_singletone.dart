import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entity/fraction_entity.dart';

class Fraction {
  Fraction._privateConstructor() {
    _getData();
  }

  static Fraction? _instance;
  List<FractionEntity> _allFraction = [];

  Future<List<FractionEntity>> getData() async {
    while(_allFraction.isEmpty) {
      Future.delayed(Duration(milliseconds: 100));
    }
    return _allFraction;
  }

  static Fraction get instance {
    Fraction? localInstance = _instance;
    if (localInstance != null) {
      return localInstance;
    } else {
      Fraction newInstance = Fraction._privateConstructor();
      _instance = newInstance;
      return newInstance;
    }
  }

  Future _getData() async {
    String data = await rootBundle.loadString('assets/all_fraction.json');
    List<FractionEntity> parsedList = List<FractionEntity>.from(
        await json.decode(data).map((model) => FractionEntity.fromJson(model)));
    _allFraction = parsedList;
  }
}
