import 'dart:typed_data';

import 'package:SmashUp/domain/entity/fraction_entity.dart';
import 'package:SmashUp/domain/entity/set_enum.dart';
import 'package:hive/hive.dart';

part 'fraction_db_model.g.dart';

@HiveType(typeId: 1)
class FractionDbModel {
  FractionDbModel(
      {required this.name,
      this.imageLocal,
      this.nameUa,
      required this.setName});

  factory FractionDbModel.fromEntity(FractionEntity entity) => FractionDbModel(
      name: entity.name,
      nameUa: entity.uaName,
      imageLocal: entity.assetImage,
      setName: entity.setName);

  FractionEntity toEntity() => FractionEntity(
      name: name,
      uaName: nameUa ?? "",
      assetImage: imageLocal ?? "",
      set: SetEnum.fromString(setName),
      setName: setName);

  @HiveField(0)
  String name;
  @HiveField(1)
  String? imageLocal;
  @HiveField(2)
  String? nameUa;
  @HiveField(3)
  String setName;

}
//flutter packages pub run build_runner build