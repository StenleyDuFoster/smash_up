import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'fraction_db_model.g.dart';

@HiveType(typeId: 1)
class FractionDbModel extends HiveObject {
  FractionDbModel({required this.name, this.imageLocal, this.imageNetwork});

  factory FractionDbModel.fromJson(Map<dynamic, dynamic> json) => FractionDbModel(
      name: json['name'],
      imageNetwork: json['image_url']);

  Map<String, dynamic> toJson() =>
      {"name": name, 'image_url': imageNetwork};

  @HiveField(0)
  String name;
  @HiveField(1)
  String? imageLocal;
  @HiveField(2)
  String? imageNetwork;

  Uint8List? imageMemory;
}
