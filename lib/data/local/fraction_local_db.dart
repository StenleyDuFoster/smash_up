import 'package:SmashUp/domain/entity/fraction_entity.dart';
import 'package:hive/hive.dart';

import '../../domain/db_model/fraction_db_model.dart';

class FractionLocalDb {

  FractionLocalDb._privateConstructor() {
    _initBox();
  }

  static FractionLocalDb? _instance;

  static FractionLocalDb instance() {
    FractionLocalDb? localInstance = _instance;
    if (localInstance != null) {
      return localInstance;
    } else {
      FractionLocalDb newInstance = FractionLocalDb._privateConstructor();
      _instance = newInstance;
      return newInstance;
    }
  }

  Box<FractionDbModel>? box;
  final String boxName = "fraction";


  Future<List<FractionEntity>> getPreviousSelectedFraction() async {
    try {
      await _initBox();
      return (box?.values?.toList() ?? List.empty()).map((e) => e.toEntity()).toList();
    } catch (e) {
      return List.empty();
    }
  }

  Future saveSelectedFraction(List<FractionEntity> data) async {
    await _initBox();
    await box?.clear();
    await box?.addAll(data.map((e) => FractionDbModel.fromEntity(e)).toList());
  }

  Future _initBox() async {
    box ??= await Hive.openBox(boxName);
  }
}
