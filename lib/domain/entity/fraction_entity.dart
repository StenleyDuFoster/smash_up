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
