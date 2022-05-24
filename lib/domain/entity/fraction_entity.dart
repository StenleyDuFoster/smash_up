import 'dart:collection';

import 'package:SmashUp/domain/entity/set_enum.dart';
import 'package:flutter/cupertino.dart';

class FractionEntity {
  FractionEntity(
      {required this.name,
      required this.uaName,
      required this.assetImage,
      required this.set,
      required this.setName});

  factory FractionEntity.fromJson(Map<dynamic, dynamic> json) => FractionEntity(
      name: json['name'],
      uaName: json['name_ua'],
      assetImage: json['asset_image'] ?? "smash_up_small_logo.jpg",
      set: SetEnum.fromString(json['set']),
      setName: json['set']);

  factory FractionEntity.fromEntry(FractionEntry entry) => FractionEntity(
      name: entry.name,
      uaName: entry.uaName,
      assetImage: entry.assetImage,
      set: entry.set,
      setName: entry.setName);

  String name;
  String uaName;
  String assetImage;
  SetEnum set;
  String setName;

  String getLocalizedName(Locale locale) {
    if (locale.languageCode == "uk")
      return uaName;
    else
      return name;
  }

  String getAssetImage() {
    return "assets/image/" + assetImage;
  }

  @override
  bool operator ==(Object other) {
    if (other is FractionEntity && other.name == this.name) {
      return true;
    }
    return false;
  }
}

class FractionEntry extends LinkedListEntry<FractionEntry> {
  FractionEntry._constructor(
      {required this.name,
      required this.uaName,
      required this.assetImage,
      required this.set,
      required this.setName});

  String name;
  String uaName;
  String assetImage;
  SetEnum set;
  String setName;

  factory FractionEntry.fromEntry(FractionEntity entity) => FractionEntry._constructor(
      name: entity.name,
      uaName: entity.uaName,
      assetImage: entity.assetImage,
      set: entity.set,
      setName: entity.setName);
}
