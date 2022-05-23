// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraction_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FractionDbModelAdapter extends TypeAdapter<FractionDbModel> {
  @override
  final int typeId = 1;

  @override
  FractionDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FractionDbModel(
      name: fields[0] as String,
      imageLocal: fields[1] as String?,
      nameUa: fields[2] as String?,
      setName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FractionDbModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageLocal)
      ..writeByte(2)
      ..write(obj.nameUa)
      ..writeByte(3)
      ..write(obj.setName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FractionDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
