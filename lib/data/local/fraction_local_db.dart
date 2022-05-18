import 'package:hive/hive.dart';
import 'package:smash_up/domain/db_model/fraction_db_model.dart';

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


  Future<List<FractionDbModel>> getAllFraction() async {
    try {
      await _initBox();
      return box?.values?.toList() ?? List.empty();
    } catch (e) {
      return List.empty();
    }
  }

  Future addFraction(FractionDbModel model) async {
    await _initBox();
    await box?.add(model);
  }

  Future _initBox() async {
    box ??= await Hive.openBox(boxName);
  }
}
